// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final uri = Uri.parse(
    'https://pub.dev/api/publishers/ksaikiran.tech/packages',
  );
  final resp = await http.get(uri);
  if (resp.statusCode != 200) {
    print('HTTP ${resp.statusCode}');
    return;
  }
  final m = json.decode(resp.body) as Map<String, dynamic>;
  final raw = m['packages'];
  if (raw is List) {
    for (final item in raw) {
      if (item is String)
        print(item);
      else if (item is Map<String, dynamic>)
        print(item['package'] ?? item['name']);
    }
  }
}
