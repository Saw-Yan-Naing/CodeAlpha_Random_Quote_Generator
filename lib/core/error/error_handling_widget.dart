import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/error/error_dialog.dart';

import 'app_error_catching.dart';
import 'error_provider.dart';

class ErrorHandlingWidget extends StatelessWidget {
  final Widget child;

  const ErrorHandlingWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final error = ref.watch(errorProvider);
        debugPrint(
          'ErrorHandlingWidget: ${error.currentError?.stackTrace} \n ${error.currentError?.message} \n ${error.currentError?.errorDisplayType}',
        );
        switch (error.currentError?.errorDisplayType) {
          case ErrorDisplayType.dialog:
            if (error.currentError != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (cxt) {
                    return ErrorDialog(error: error.currentError);
                  },
                );
              });
            }
            break;
          case ErrorDisplayType.snackbar:
            if (error.currentError != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.currentError!.message),
                    action: SnackBarAction(
                      label: 'Retry',
                      onPressed: () {
                        error.clearError();
                        error.currentError?.onRetry?.call();
                      },
                    ),
                  ),
                );
              });
            }
            break;
          default:
        }

        return child;
      },
    );
  }
}
