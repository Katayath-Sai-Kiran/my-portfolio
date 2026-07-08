import 'package:flutter/material.dart';
import '../design/app_spacing.dart';

abstract final class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppSpacing.mobileBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppSpacing.tabletBreakpoint;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppSpacing.tabletBreakpoint;

  static double sectionH(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < AppSpacing.mobileBreakpoint) return AppSpacing.sectionHMobile;
    if (w < AppSpacing.tabletBreakpoint) return AppSpacing.sectionHTablet;
    return AppSpacing.sectionHDesktop;
  }

  static double sectionV(BuildContext context) =>
      isMobile(context) ? AppSpacing.sectionVMobile : AppSpacing.sectionV;
}
