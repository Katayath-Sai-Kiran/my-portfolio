import 'package:flutter/material.dart';

abstract final class ScrollUtils {
  static Future<void> scrollToSection(
    ScrollController controller,
    GlobalKey key,
  ) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}
