import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/error/error_handling_widget.dart';
import 'package:random_quote_generator/quote_generator/presentation/quote_generator_page.dart';

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
      // showDialog(
      //   context: navigatorKey.currentContext!,
      //   builder: (cxt) {
      //     return Dialog(
      //       backgroundColor: Colors.white,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       shadowColor: Colors.blueGrey.withValues(alpha: .5),
      //       child: Container(
      //         padding: const EdgeInsets.all(20),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             const Text('Error Occurred in async'),
      //             const SizedBox(height: 10),
      //             Text(error.toString()),
      //             const SizedBox(height: 10),
      //             Text(stackTrace.toString()),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // );
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
