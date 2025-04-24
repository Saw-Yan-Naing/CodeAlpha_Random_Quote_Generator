import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:random_quote_generator/core/error/app_error_catching.dart';
import 'package:random_quote_generator/core/presentation/screen_size.dart';

class ErrorDialog extends StatelessWidget {
  final AppError? error;
  const ErrorDialog({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenSize.isMobile(context: context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.blueGrey.withValues(alpha: .5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width:
              ScreenSize.getScreenWidth(context: context) *
              (isMobile ? 0.9 : 0.5),
          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                error?.statusCode ?? "Error Occured",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Flexible(
                child: SingleChildScrollView(
                  child:
                      (!kDebugMode)
                          ? Text(
                            error?.message ?? "An error occurred",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                          : Column(
                            children: [
                              Text(
                                error?.message ?? "An error occurred",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                error?.stackTrace?.toString() ??
                                    "No stack trace available",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 43,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
