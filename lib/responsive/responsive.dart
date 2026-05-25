import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) => MediaQuery.sizeOf(context).height;

  static bool isTinyPhone(BuildContext context) => width(context) < 360;

  static bool isSmallPhone(BuildContext context) => width(context) < 430;

  static bool isMobile(BuildContext context) =>
      width(context) < 768 || (width(context) < 950 && height(context) < 500);

  static bool isTablet(BuildContext context) {
    final w = width(context);
    return !isMobile(context) && w >= 768 && w < 1100;
  }

  static bool isDesktop(BuildContext context) =>
      !isMobile(context) && width(context) >= 1100;

  static bool isCompactDesktop(BuildContext context) {
    final w = width(context);
    return w >= 1100 && w < 1280;
  }

  static double horizontalPadding(BuildContext context) {
    final w = width(context);
    if (w < 360) return 14;
    if (w < 430) return 16;
    if (w < 768) return 20;
    if (w < 1280) return 28;
    return 32;
  }

  static double sectionPadding(BuildContext context) {
    final w = width(context);
    if (w < 360) return 54;
    if (w < 430) return 62;
    if (w < 768) return 72;
    if (w < 1100) return 84;
    return 96;
  }

  static double value(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? (mobile + desktop) / 2;
    return mobile;
  }
}
