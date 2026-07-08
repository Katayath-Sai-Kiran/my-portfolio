import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
final class AppTheme {
  const AppTheme._();

  static ThemeData get dark => _build(Brightness.dark, PortfolioColors.dark);
  static ThemeData get light => _build(Brightness.light, PortfolioColors.light);

  static ThemeData _build(Brightness brightness, PortfolioColors c) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: c.background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.accent,
        onPrimary: Colors.white,
        secondary: c.sage,
        onSecondary: Colors.white,
        error: const Color(0xFFD95959),
        onError: Colors.white,
        surface: c.surface,
        onSurface: c.textPrimary,
        outline: c.border,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelSmall: AppTypography.labelSmall,
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide.none,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.accentBg,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        labelStyle: AppTypography.monoSmall.copyWith(color: c.accent),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      iconTheme: IconThemeData(color: c.textSecondary),
    );
  }
}
