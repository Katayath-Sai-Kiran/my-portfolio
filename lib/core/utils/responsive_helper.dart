import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

abstract final class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppDimensions.mobileBreakpoint;

  static bool isMedium(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= AppDimensions.mobileBreakpoint &&
        w < AppDimensions.mediumBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= AppDimensions.mobileBreakpoint &&
        w < AppDimensions.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.tabletBreakpoint;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.mediumBreakpoint;

  static double sectionHorizontalPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < AppDimensions.mobileBreakpoint) {
      return AppDimensions.sectionPaddingHorizontalMobile;
    }
    if (w < AppDimensions.tabletBreakpoint) {
      return AppDimensions.sectionPaddingHorizontalTablet;
    }
    return AppDimensions.sectionPaddingHorizontalDesktop;
  }

  static double sectionVerticalPadding(BuildContext context) =>
      isMobile(context)
          ? AppDimensions.sectionPaddingVerticalMobile
          : AppDimensions.sectionPaddingVertical;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? medium,
    required T desktop,
  }) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= AppDimensions.tabletBreakpoint) return desktop;
    if (w >= AppDimensions.mediumBreakpoint) return medium ?? desktop;
    if (w >= AppDimensions.mobileBreakpoint) return tablet ?? medium ?? desktop;
    return mobile;
  }
}
