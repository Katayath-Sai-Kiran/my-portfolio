import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

abstract final class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppDimensions.mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= AppDimensions.mobileBreakpoint &&
        w < AppDimensions.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.tabletBreakpoint;

  static double sectionHorizontalPadding(BuildContext context) =>
      isMobile(context)
      ? AppDimensions.sectionPaddingHorizontalMobile
      : AppDimensions.sectionPaddingHorizontalDesktop;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }
}
