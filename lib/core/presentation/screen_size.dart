import 'package:flutter/material.dart';
import 'package:random_quote_generator/main.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ScreenSize {
  static bool isMobile(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isMobile ||
        MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop() {
    return MediaQuery.of(navigatorKey.currentContext!).size.width >= 1200;
  }

  static Size getScreenSize() {
    return MediaQuery.of(navigatorKey.currentContext!).size;
  }

  static double getScreenHeight() {
    return MediaQuery.of(navigatorKey.currentContext!).size.height;
  }

  static double getScreenWidth() {
    return MediaQuery.of(navigatorKey.currentContext!).size.width;
  }
}
