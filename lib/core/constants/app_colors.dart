import 'package:flutter/material.dart';

/// Color palette derived from the Flat UI dark swatch:
/// #2C3E50 · #34495E · #7F8C8D · #BDC3C7 · #ECF0F1
abstract final class AppColors {
  // Primary palette — teal-gray accent from palette
  static const Color primary = Color(0xFF7F8C8D);
  static const Color primaryLight = Color(0xFFBDC3C7);
  static const Color primaryDark = Color(0xFF5D6D6E);

  // Background
  static const Color backgroundDark = Color(0xFF2C3E50);
  static const Color backgroundCard = Color(0xFF34495E);
  static const Color backgroundCardLight = Color(0xFF3D566E);

  // Text
  static const Color textPrimary = Color(0xFFECF0F1);
  static const Color textSecondary = Color(0xFFBDC3C7);
  static const Color textMuted = Color(0xFF7F8C8D);

  // Accent — silver highlight + warm-white
  static const Color accent = Color(0xFFBDC3C7);
  // orange accent used across the site
  static const Color accentSecondary = Color(0xFFFF9800); // material orange 500

  // UI chrome
  static const Color divider = Color(0xFF3D566E);
  static const Color border = Color(0xFF4A6278);
  static const Color success = Color(0xFF1ABC9C);
  static const Color error = Color(0xFFE74C3C);
}
