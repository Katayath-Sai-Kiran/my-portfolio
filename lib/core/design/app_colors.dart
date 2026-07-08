import 'package:flutter/material.dart';

class PortfolioColors {
  const PortfolioColors({
    required this.background,
    required this.surface,
    required this.surfaceHover,
    required this.surfaceElevated,
    required this.border,
    required this.borderSubtle,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.accentSubtle,
    required this.accentBg,
    required this.sage,
    required this.sageBg,
    required this.navBg,
  });

  final Color background;
  final Color surface;
  final Color surfaceHover;
  final Color surfaceElevated;
  final Color border;
  final Color borderSubtle;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color accent;
  final Color accentSubtle;
  final Color accentBg;
  final Color sage;
  final Color sageBg;
  final Color navBg;

  static PortfolioColors of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;

  static const PortfolioColors light = PortfolioColors(
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF2F2F2),
    surfaceHover: Color(0xFFE8E8E8),
    surfaceElevated: Color(0xFFFFFFFF),
    border: Color(0xFFD9D9D9),
    borderSubtle: Color(0xFFE6E6E6),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF4D4D4D),
    textMuted: Color(0xFF808080),
    accent: Color(0xFF000000),
    accentSubtle: Color(0xFF333333),
    accentBg: Color(0xFFEBEBEB),
    sage: Color(0xFF808080),
    sageBg: Color(0xFFEBEBEB),
    navBg: Color(0xFFFFFFFF),
  );

  static const PortfolioColors dark = PortfolioColors(
    background: Color(0xFF000000),
    surface: Color(0xFF1A1A1A),
    surfaceHover: Color(0xFF242424),
    surfaceElevated: Color(0xFF2E2E2E),
    border: Color(0xFF333333),
    borderSubtle: Color(0xFF262626),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB3B3B3),
    textMuted: Color(0xFF808080),
    accent: Color(0xFFFFFFFF),
    accentSubtle: Color(0xFFCCCCCC),
    accentBg: Color(0xFF262626),
    sage: Color(0xFF808080),
    sageBg: Color(0xFF262626),
    navBg: Color(0xFF000000),
  );
}
