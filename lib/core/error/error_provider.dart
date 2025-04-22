import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/error/app_error_catching.dart';

class ErrorProvider extends ChangeNotifier {
  AppError? _error;
  bool _isShowing = false;

  AppError? get currentError => _error;

  void showError(AppError error) {
    if (_isShowing) return;

    _error = error;
    _isShowing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void callBack() {
    if (_error != null) {
      _error!.onRetry?.call();
      _error = null;
      _isShowing = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void clearError() {
    _error = null;
    _isShowing = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}

final errorProvider = ChangeNotifierProvider<ErrorProvider>((ref) {
  return ErrorProvider();
});
