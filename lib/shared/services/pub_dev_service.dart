import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Fetches live package data from the pub.dev REST API.
///
/// Endpoints used:
///  • `GET /api/packages/{name}`               – metadata (version, published)
///  • `GET /api/packages/{name}/score`          – likes, pub points, popularity
///  • `GET /api/packages/{name}/download-counts` – raw download totals
class PubDevService {
  PubDevService._();
  static final PubDevService instance = PubDevService._();

  // Simple in-memory caches so each package is only fetched once per session.
  final Map<String, PackageLiveData> _cache = {};
  final Map<String, Future<PackageLiveData>> _inflight = {};

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Fetch all live data for [packageName] in parallel (metadata + score + downloads).
  Future<PackageLiveData> fetchAll(String packageName) {
    if (_cache.containsKey(packageName)) {
      return Future.value(_cache[packageName]!);
    }
    if (_inflight.containsKey(packageName)) {
      return _inflight[packageName]!;
    }
    final future = _fetchAll(packageName);
    _inflight[packageName] = future;
    future.then((data) {
      _cache[packageName] = data;
      _inflight.remove(packageName);
    }).catchError((_) {
      _inflight.remove(packageName);
    });
    return future;
  }

  /// Fetch live data for all packages in parallel.
  Future<Map<String, PackageLiveData>> fetchAllForPackages(
    List<String> names,
  ) async {
    final results = await Future.wait(names.map(fetchAll));
    return {for (var i = 0; i < names.length; i++) names[i]: results[i]};
  }

  // ── Legacy compat (used by older cards) ────────────────────────────────────

  /// Returns a map with `downloads` key, or null on error.
  /// Kept for backward compat with package cards.
  Future<Map<String, dynamic>?> fetchPackageInfo(String packageName) async {
    try {
      final data = await fetchAll(packageName);
      return {
        'name': packageName,
        'downloads': data.totalDownloads,
        'version': data.version,
        'likeCount': data.likeCount,
        'pubPoints': data.pubPoints,
      };
    } catch (_) {
      return null;
    }
  }

  // ── Internal ───────────────────────────────────────────────────────────────

  Future<PackageLiveData> _fetchAll(String packageName) async {
    // Fire all three requests in parallel
    final results = await Future.wait([
      _fetchMeta(packageName),
      _fetchScore(packageName),
      _fetchDownloadCounts(packageName),
    ]);

    final meta = results[0] as Map<String, dynamic>?;
    final score = results[1] as Map<String, dynamic>?;
    final dlCount = results[2] as int?;

    return PackageLiveData(
      name: packageName,
      version: meta?['version'] as String?,
      publishedAt: meta?['publishedAt'] as DateTime?,
      totalDownloads: dlCount,
      likeCount: score?['likeCount'] as int?,
      pubPoints: score?['grantedPoints'] as int?,
      popularityScore: (score?['popularityScore'] as num?)?.toDouble(),
    );
  }

  /// `GET /api/packages/{name}` – returns version + published date.
  Future<Map<String, dynamic>?> _fetchMeta(String name) async {
    try {
      final resp = await http.get(
        Uri.parse('https://pub.dev/api/packages/$name'),
      );
      if (resp.statusCode != 200) return null;
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      final latest = json['latest'] as Map<String, dynamic>?;
      final pubspec = latest?['pubspec'] as Map<String, dynamic>?;
      DateTime? published;
      final rawDate = latest?['published'] as String?;
      if (rawDate != null) {
        published = DateTime.tryParse(rawDate);
      }
      return {
        'version': pubspec?['version'],
        'publishedAt': published,
      };
    } catch (e) {
      _debugLog('_fetchMeta($name) error: $e');
      return null;
    }
  }

  /// `GET /api/packages/{name}/score` – returns likes, pub points, popularity.
  Future<Map<String, dynamic>?> _fetchScore(String name) async {
    try {
      final resp = await http.get(
        Uri.parse('https://pub.dev/api/packages/$name/score'),
      );
      if (resp.statusCode != 200) return null;
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      return {
        'likeCount': json['likeCount'] as int?,
        'grantedPoints': json['grantedPoints'] as int?,
        'maxPoints': json['maxPoints'] as int?,
        'popularityScore': json['popularityScore'],
      };
    } catch (e) {
      _debugLog('_fetchScore($name) error: $e');
      return null;
    }
  }

  /// `GET /api/packages/{name}/download-counts` – returns total downloads.
  ///
  /// The response contains a `counts` array of `{date, totalCount}` objects
  /// (30-day rolling window). We take the most recent entry's `totalCount`
  /// which is the cumulative lifetime total, or sum the window if needed.
  Future<int?> _fetchDownloadCounts(String name) async {
    try {
      final resp = await http.get(
        Uri.parse('https://pub.dev/api/packages/$name/download-counts'),
      );
      if (resp.statusCode != 200) {
        _debugLog('_fetchDownloadCounts($name): HTTP ${resp.statusCode}');
        return null;
      }
      final json = jsonDecode(resp.body) as Map<String, dynamic>;

      // Try direct totalCount key first
      if (json['totalCount'] is int) {
        return json['totalCount'] as int;
      }

      // counts array: [{date, totalCount}, ...] — take the latest
      final counts = json['counts'];
      if (counts is List && counts.isNotEmpty) {
        final last = counts.last;
        if (last is Map<String, dynamic>) {
          final total = last['totalCount'] ?? last['total'] ?? last['count'];
          if (total is int) return total;
        }
      }

      // Fallback: any int key with "total" or "download" in its name
      for (final entry in json.entries) {
        if (entry.value is int) {
          final k = entry.key.toLowerCase();
          if (k.contains('total') || k.contains('download')) {
            return entry.value as int;
          }
        }
      }

      _debugLog('_fetchDownloadCounts($name): could not parse. Keys=${json.keys}');
      return null;
    } catch (e) {
      _debugLog('_fetchDownloadCounts($name) error: $e');
      return null;
    }
  }

  void _debugLog(String msg) {
    if (kDebugMode) debugPrint('[PubDevService] $msg');
  }
}

/// All live data fetched from pub.dev for one package.
class PackageLiveData {
  const PackageLiveData({
    required this.name,
    this.version,
    this.publishedAt,
    this.totalDownloads,
    this.likeCount,
    this.pubPoints,
    this.popularityScore,
  });

  final String name;
  final String? version;
  final DateTime? publishedAt;
  final int? totalDownloads;
  final int? likeCount;
  final int? pubPoints;
  final double? popularityScore;

  String formatDownloads() {
    final d = totalDownloads;
    if (d == null) return '–';
    if (d >= 1000000) return '${(d / 1000000).toStringAsFixed(1)}M';
    if (d >= 1000) return '${(d / 1000).toStringAsFixed(1)}k';
    return d.toString();
  }
}
