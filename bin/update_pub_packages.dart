import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> main() async {
  final repoRoot = Directory.current.path;
  final dataPath = '$repoRoot/lib/shared/data/portfolio_data.dart';
  final file = File(dataPath);
  if (!await file.exists()) {
    stderr.writeln('File not found: $dataPath');
    exit(2);
  }
  final text = await file.readAsString();
  final startMarker = 'static const List<OpenSourcePackage> packages = [';
  final startIndex = text.indexOf(startMarker);
  if (startIndex < 0) {
    stderr.writeln('Could not find packages block in portfolio_data.dart');
    exit(2);
  }
  final endIndex = text.indexOf('];', startIndex);
  if (endIndex < 0) {
    stderr.writeln('Could not find end of packages block');
    exit(2);
  }
  final block = text.substring(startIndex, endIndex);

  final nameRegex = RegExp("name:\\s*'([^']+)'", multiLine: true);
  final matches = nameRegex.allMatches(block).map((m) => m.group(1)!).toList();
  if (matches.isEmpty) {
    stderr.writeln('No package names found in packages block');
    exit(2);
  }

  final result = <String, dynamic>{};
  for (final name in matches) {
    stderr.writeln('Fetching $name');
    final uri = Uri.parse('https://pub.dev/api/packages/$name');
    try {
      final resp = await http.get(uri).timeout(const Duration(seconds: 15));
      if (resp.statusCode != 200) {
        stderr.writeln('  HTTP ${resp.statusCode} for $name');
        result[name] = {'error': 'http_${resp.statusCode}'};
        continue;
      }
      final Map<String, dynamic> jsonMap = json.decode(resp.body);
      final latest = jsonMap['latest'] as Map<String, dynamic>?;
      String? description;
      List<String> topics = [];
      if (latest != null) {
        final pubspec = latest['pubspec'] as Map<String, dynamic>?;
        if (pubspec != null) {
          description = pubspec['description'] as String?;
          final rawTopics = pubspec['topics'];
          if (rawTopics is List) {
            topics = rawTopics.whereType<String>().toList();
          }
        }
      }
      // Fallback: top-level description if present
      description ??= jsonMap['description'] as String?;
      result[name] = {'description': description, 'topics': topics};
    } catch (e) {
      stderr.writeln('  Error fetching $name: $e');
      result[name] = {'error': e.toString()};
    }
  }

  stdout.writeln(json.encode(result));
}
