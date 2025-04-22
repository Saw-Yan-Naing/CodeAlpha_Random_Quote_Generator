import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';

class AppError implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final ErrorDisplayType errorDisplayType;
  final VoidCallback? onRetry;
  const AppError(
    this.message,
    this.stackTrace,
    this.errorDisplayType, {
    this.onRetry,
  });
}

class Result<T> {
  final T? data;
  final AppError? error;

  Result._({this.data, this.error});

  static Result<T> success<T>(T data) {
    return Result._(data: data);
  }

  static Result<T> failure<T>(AppError error) {
    return Result._(error: error);
  }

  bool get isSuccess => data != null && error == null;
}

AppError getError(
  dynamic e, {
  ErrorDisplayType errorDisplayType = ErrorDisplayType.dialog,
}) {
  if (e is SocketException || e is HttpException) {
    return AppError(
      'Network error occurred with ${e.message}',
      StackTrace.current,
      errorDisplayType,
    );
  } else if (e is FormatException) {
    return AppError(e.message, StackTrace.current, errorDisplayType);
  } else if (e is DioException) {
    return AppError(
      'Dio error occurred with ${e.message}',
      StackTrace.current,
      errorDisplayType,
    );
  } else if (e is Exception) {
    return AppError(
      'Exception occurred with ${e.toString()}',
      StackTrace.current,
      errorDisplayType,
    );
  } else {
    return AppError(
      'Unknown error occurred',
      StackTrace.current,
      errorDisplayType,
    );
  }
}

enum ErrorDisplayType { dialog, snackbar, none }
