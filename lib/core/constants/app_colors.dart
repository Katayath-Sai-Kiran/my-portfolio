import 'package:flutter/material.dart';

/// Theme-aware color palette. Use [PortfolioColors.of(context)] in widgets.
class PortfolioColors {
  const PortfolioColors({
    required this.background,
    required this.surface,
    required this.surfaceHover,
    required this.border,
    required this.borderStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.accentSubtle,
    required this.accentBg,
    required this.orange,
    required this.success,
    required this.navBg,
  });

  final Color background;
  final Color surface;
  final Color surfaceHover;
  final Color border;
  final Color borderStrong;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  /// Indigo – primary CTA, highlights, active states.
  final Color accent;

  /// Lighter indigo – icons, muted accents, hover text.
  final Color accentSubtle;

  /// Very transparent indigo – chip backgrounds, tag fills.
  final Color accentBg;

  /// Warm orange – download counts, stat numbers.
  final Color orange;

  /// Emerald – success, growth indicators.
  final Color success;

  /// Nav bar background (slightly more opaque for glass effect).
  final Color navBg;

  static PortfolioColors of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? AppColors.dark
      : AppColors.light;
}

abstract final class AppColors {
  // ── Dark palette ───────────────────────────────────────────────────────────
  static const PortfolioColors dark = PortfolioColors(
    background: Color(0xFF09090E),
    surface: Color(0xFF0F0F1C),
    surfaceHover: Color(0xFF151528),
    border: Color(0xFF1E1E35),
    borderStrong: Color(0xFF2E2E48),
    textPrimary: Color(0xFFEEEEFF),
    textSecondary: Color(0xFF8888AA),
    textMuted: Color(0xFF555570),
    accent: Color(0xFF6366F1),
    accentSubtle: Color(0xFF818CF8),
    accentBg: Color(0x1A6366F1),
    orange: Color(0xFFF97316),
    success: Color(0xFF22C55E),
    navBg: Color(0xF009090E),
  );

  // ── Light palette ──────────────────────────────────────────────────────────
  static const PortfolioColors light = PortfolioColors(
    background: Color(0xFFFAFAFF),
    surface: Color(0xFFFFFFFF),
    surfaceHover: Color(0xFFF0F0FA),
    border: Color(0xFFE2E2F0),
    borderStrong: Color(0xFFCECEE8),
    textPrimary: Color(0xFF0C0C1C),
    textSecondary: Color(0xFF56567A),
    textMuted: Color(0xFF9090A8),
    accent: Color(0xFF4F46E5),
    accentSubtle: Color(0xFF6366F1),
    accentBg: Color(0x0D4F46E5),
    orange: Color(0xFFEA6A0A),
    success: Color(0xFF16A34A),
    navBg: Color(0xF5FAFAFF),
  );

  // ── Static aliases kept for legacy compatibility ───────────────────────────
  // (Remove when all references are migrated to PortfolioColors.of(context))
  static const Color backgroundDark = Color(0xFF09090E);
  static const Color backgroundCard = Color(0xFF0F0F1C);
  static const Color backgroundCardLight = Color(0xFF151528);
  static const Color border = Color(0xFF1E1E35);
  static const Color textPrimary = Color(0xFFEEEEFF);
  static const Color textSecondary = Color(0xFF8888AA);
  static const Color textMuted = Color(0xFF555570);
  static const Color accent = Color(0xFF6366F1);
  static const Color accentSecondary = Color(0xFFF97316);
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4338CA);
  static const Color divider = Color(0xFF1E1E35);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
}
