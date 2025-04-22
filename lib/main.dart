import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/error/error_handling_widget.dart';
import 'package:random_quote_generator/quote_generator/presentation/quote_generator_page.dart';

import 'core/error/app_error_catching.dart';
import 'core/error/error_dialog.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.exceptionAsString());
  };
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
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
      home: ErrorHandlingWidget(child: QuoteGeneratorPage()),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    );
  }
}
