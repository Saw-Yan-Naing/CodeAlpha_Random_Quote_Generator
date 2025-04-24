import 'package:flutter/material.dart';
import 'package:random_quote_generator/main.dart';

class ScreenSize {
  static bool isMobile({BuildContext? context}) {
    return MediaQuery.of(context ?? navigatorKey.currentContext!).size.width <
        600;
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

  static double getScreenWidth({BuildContext? context}) {
    return MediaQuery.of(context ?? navigatorKey.currentContext!).size.width;
  }
}
