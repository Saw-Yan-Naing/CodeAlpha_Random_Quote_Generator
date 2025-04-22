import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:random_quote_generator/core/error/app_error_catching.dart';

class ErrorDialog extends StatelessWidget {
  final AppError? error;
  const ErrorDialog({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.blueGrey.withValues(alpha: .5),
      child: Column(
        spacing: 20,
        children: [
          Text(
            error?.statusCode ?? "Error Occured",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SingleChildScrollView(
            child:
                (kDebugMode)
                    ? Text(
                      error?.message ?? "An error occurred",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                    : Column(
                      children: [
                        Text(
                          error?.message ?? "An error occurred",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          error?.stackTrace?.toString() ??
                              "No stack trace available",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
