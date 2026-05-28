// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<void> main() async {
  final url = Uri.parse('https://pub.dev/publishers/ksaikiran.tech/packages');
  final r = await http.get(url);
  if (r.statusCode != 200) {
    log('HTTP ${r.statusCode}');
    return;
  }
  final body = r.body;
  final regex = RegExp(r"/packages/([-a-zA-Z0-9_]+)");
  final matches =
      regex.allMatches(body).map((m) => m.group(1)!).toSet().toList()..sort();
  for (final m in matches) log(m);
}
