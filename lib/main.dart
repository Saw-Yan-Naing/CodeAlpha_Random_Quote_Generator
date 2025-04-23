import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/error/error_handling_widget.dart';
import 'package:random_quote_generator/quote_generator/presentation/quote_generator_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:window_manager/window_manager.dart';

import 'core/error/app_error_catching.dart';
import 'core/error/error_dialog.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.exceptionAsString());
  };
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        await windowManager.ensureInitialized();

        WindowOptions windowOptions = WindowOptions(
          minimumSize: Size(1000, 600),
          center: true,
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          titleBarStyle: TitleBarStyle.normal,
          title: "Random Quote Generator",
        );
        windowManager.waitUntilReadyToShow(windowOptions, () async {
          await windowManager.show();
          await windowManager.focus();
        });
      }
      runApp(
        UncontrolledProviderScope(
          container: ProviderContainer(),
          child: const MainApp(),
        ),
      );
    },
    (error, stackTrace) {
      debugPrint(
        "Run Guarded Error  ${error.toString()} \n ${stackTrace.toString()}",
      );
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'Run Guarded',
          context: ErrorDescription('Run Guarded Error'),
        ),
      );
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return ErrorDialog(
            error: AppError(
              statusCode: Error.safeToString(error),
              message: 'An error occurred.',
              stackTrace: stackTrace,
              errorDisplayType: ErrorDisplayType.dialog,
            ),
          );
        },
      );
    },
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveBreakpoints.builder(
        child: ErrorHandlingWidget(child: QuoteGeneratorPage()),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    );
  }
}
