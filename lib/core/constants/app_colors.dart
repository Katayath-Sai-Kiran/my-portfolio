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
  // ── Brutalist palette ───────────────────────────────────────────────────────
  // Concrete/newsprint surfaces, ink-black structure, two loud primaries:
  //   accent = vermilion (the loud color), orange = electric blue (used sparingly).
  // Borders are near-black and hard; nothing is soft, glassy, or glowing.

  // ── Dark (void) ──────────────────────────────────────────────────────────────
  static const PortfolioColors dark = PortfolioColors(
    background: Color(0xFF0C0C0A),
    surface: Color(0xFF161613),
    surfaceHover: Color(0xFF1F1F1A),
    border: Color(0xFF3A3A33),
    borderStrong: Color(0xFFF4F2EA),
    textPrimary: Color(0xFFF4F2EA),
    textSecondary: Color(0xFFA8A89C),
    textMuted: Color(0xFF6E6E63),
    accent: Color(0xFFFF4A22),
    accentSubtle: Color(0xFFFF6A45),
    accentBg: Color(0xFF2A1710),
    orange: Color(0xFF4D6BFF),
    success: Color(0xFF3BD171),
    navBg: Color(0xFF0C0C0A),
  );

  // ── Light (concrete) ──────────────────────────────────────────────────────────
  static const PortfolioColors light = PortfolioColors(
    background: Color(0xFFE6E3DA),
    surface: Color(0xFFF5F3EC),
    surfaceHover: Color(0xFFFFFFFF),
    border: Color(0xFF14140F),
    borderStrong: Color(0xFF000000),
    textPrimary: Color(0xFF0A0A08),
    textSecondary: Color(0xFF3C3C34),
    textMuted: Color(0xFF6B6B61),
    accent: Color(0xFFE53310),
    accentSubtle: Color(0xFFC22A0C),
    accentBg: Color(0xFFFCE3DB),
    orange: Color(0xFF1B1AFF),
    success: Color(0xFF0F8A3C),
    navBg: Color(0xFFE6E3DA),
  );

  // ── Static aliases kept for legacy compatibility ───────────────────────────
  // (Remove when all references are migrated to PortfolioColors.of(context))
  static const Color backgroundDark = Color(0xFF0C0C0A);
  static const Color backgroundCard = Color(0xFF161613);
  static const Color backgroundCardLight = Color(0xFF1F1F1A);
  static const Color border = Color(0xFF3A3A33);
  static const Color textPrimary = Color(0xFFF4F2EA);
  static const Color textSecondary = Color(0xFFA8A89C);
  static const Color textMuted = Color(0xFF6E6E63);
  static const Color accent = Color(0xFFFF4A22);
  static const Color accentSecondary = Color(0xFF4D6BFF);
  static const Color primary = Color(0xFFFF4A22);
  static const Color primaryLight = Color(0xFFFF6A45);
  static const Color primaryDark = Color(0xFFC22A0C);
  static const Color divider = Color(0xFF3A3A33);
  static const Color error = Color(0xFFE53310);
  static const Color success = Color(0xFF3BD171);
}
