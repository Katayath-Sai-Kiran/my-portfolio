import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Service to fetch package info from pub.dev API.
/// - fetchDownloads(packageName): returns total downloads or null.
/// - fetchPackagesByPublisher(publisherId): returns list of package names.
/// - fetchDownloadsForPublisher(publisherId): convenience to fetch all downloads.
class PubDevService {
  PubDevService._();
  static final PubDevService instance = PubDevService._();

  final Map<String, int> _cache = {};
  final Map<String, Future<int?>> _inflight = {};

  /// Fetch total downloads for [packageName]. Returns null on error.
  Future<int?> fetchDownloads(String packageName) async {
    if (_cache.containsKey(packageName)) return _cache[packageName];
    if (_inflight.containsKey(packageName)) return _inflight[packageName];

    final future = _fetchDownloadsInternal(packageName);
    _inflight[packageName] = future;
    final res = await future;
    _inflight.remove(packageName);
    return res;
  }

  /// Fetch a small package info map for a package. Returns null on error.
  /// Map keys: name, description, version, published (ISO string), homepage,
  /// downloads (int or null), topics (list of strings)
  Future<Map<String, dynamic>?> fetchPackageInfo(String packageName) async {
    try {
      final uri = Uri.parse('https://pub.dev/api/packages/$packageName');
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService: fetchPackageInfo $packageName -> $uri');
      }
      final resp = await http.get(uri);
      if (resp.statusCode != 200) return null;
      final Map<String, dynamic> jsonMap = json.decode(resp.body);
      final result = <String, dynamic>{};
      result['name'] = jsonMap['name'];
      final latest = jsonMap['latest'] as Map<String, dynamic>?;
      if (latest != null) {
        final pubspec = latest['pubspec'] as Map<String, dynamic>?;
        result['version'] = pubspec != null ? pubspec['version'] : null;
        result['description'] = pubspec != null ? pubspec['description'] : null;
        result['homepage'] = pubspec != null ? pubspec['homepage'] : null;
        result['topics'] = (pubspec != null && pubspec['topics'] is List)
            ? List<String>.from(pubspec['topics'])
            : <String>[];
        result['published'] = latest['published'];
      }
      // Try downloads if present
      final packageObj = jsonMap['package'] as Map<String, dynamic>?;
      result['downloads'] = packageObj != null
          ? (packageObj['downloads'] as int?)
          : null;
      return result;
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService.fetchPackageInfo error: $e');
      }
      return null;
    }
  }

  Future<int?> _fetchDownloadsInternal(String packageName) async {
    try {
      final uri = Uri.parse('https://pub.dev/api/packages/$packageName');
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService: fetching package info for $packageName -> $uri');
      }
      final resp = await http.get(uri);

      log(resp.body, name: 'PubDevService: response for $packageName');
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService: ${uri.toString()} returned ${resp.statusCode}');
      }
      if (resp.statusCode != 200) {
        if (kDebugMode) {
          // ignore: avoid_print
          print('PubDevService: non-200 response: ${resp.body}');
        }
        return null;
      }

      final Map<String, dynamic> jsonMap = json.decode(resp.body);

      // Try common locations for a downloads count; pub.dev schema can vary.
      int? downloads;

      // 1) package.downloads
      if (jsonMap['package'] is Map<String, dynamic>) {
        downloads =
            (jsonMap['package'] as Map<String, dynamic>)['downloads'] as int?;
      }

      // 2) top-level downloads
      downloads ??= jsonMap['downloads'] as int?;

      // 3) nested in score or other fields (best-effort)
      if (downloads == null) {
        // Search shallowly for any numeric key named 'downloads' or 'downloadCount'
        for (final entry in jsonMap.entries) {
          final key = entry.key.toLowerCase();
          if (key.contains('download')) {
            final v = entry.value;
            if (v is int) {
              downloads = v;
              break;
            }
          }
        }
      }

      if (downloads == null && kDebugMode) {
        // Print small diagnostics to help debugging the API shape.
        final keys = jsonMap.keys.toList();
        // ignore: avoid_print
        print('PubDevService: package $packageName JSON keys: $keys');
        final pkgObj = jsonMap['package'];
        if (pkgObj is Map<String, dynamic>) {
          // ignore: avoid_print
          print('PubDevService: package object keys: ${pkgObj.keys.toList()}');
        }
      }

      if (downloads != null) {
        _cache[packageName] = downloads;
        if (kDebugMode) {
          // ignore: avoid_print
          print(
            'PubDevService: parsed downloads for $packageName = $downloads',
          );
        }
      }

      return downloads;
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService.fetchDownloads error: $e');
      }
      return null;
    }
  }

  /// Fetch a list of package names for a publisher, e.g. `ksaikiran.dev`.
  /// Returns null on error or an empty list if none found.
  Future<List<String>?> fetchPackagesByPublisher(String publisherId) async {
    try {
      final uri = Uri.parse(
        'https://pub.dev/api/publishers/$publisherId/packages',
      );
      if (kDebugMode) {
        // ignore: avoid_print
        print(
          'PubDevService: fetching packages for publisher $publisherId -> $uri',
        );
      }
      final resp = await http.get(uri);
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService: ${uri.toString()} returned ${resp.statusCode}');
      }
      if (resp.statusCode != 200) return null;
      final Map<String, dynamic> jsonMap = json.decode(resp.body);
      final raw = jsonMap['packages'];
      if (raw == null) return <String>[];
      final List<String> packages = [];
      if (raw is List) {
        for (final item in raw) {
          if (item is String) {
            packages.add(item);
          } else if (item is Map<String, dynamic>) {
            // Some responses may include a map with a `package` key
            final name = item['package'] ?? item['name'];
            if (name is String) packages.add(name);
          }
        }
      }
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService: publisher $publisherId has packages: $packages');
      }

      return packages;
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('PubDevService.fetchPackagesByPublisher error: $e');
      }
      return null;
    }
  }

  /// Convenience: fetch downloads for all packages of a publisher.
  Future<Map<String, int?>> fetchDownloadsForPublisher(
    String publisherId,
  ) async {
    final result = <String, int?>{};
    final names = await fetchPackagesByPublisher(publisherId);
    if (names == null) return result;
    for (final n in names) {
      final d = await fetchDownloads(n);
      result[n] = d;
    }
    return result;
  }
}
