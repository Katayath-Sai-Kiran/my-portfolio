import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get dark => _build(Brightness.dark, AppColors.dark);
  static ThemeData get light => _build(Brightness.light, AppColors.light);

  static ThemeData _build(Brightness brightness, PortfolioColors c) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: c.background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.accent,
        onPrimary: Colors.white,
        secondary: c.orange,
        onSecondary: Colors.white,
        error: const Color(0xFFEF4444),
        onError: Colors.white,
        surface: c.surface,
        onSurface: c.textPrimary,
        outline: c.border,
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1.5),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: c.border, width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.accentBg,
        side: BorderSide(color: c.border, width: 1.5),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      iconTheme: IconThemeData(color: c.textPrimary),
    );
  }
}
