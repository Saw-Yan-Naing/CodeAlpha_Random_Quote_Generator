import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';

class AppError implements Exception {
  final String? statusCode;
  final String message;
  final StackTrace? stackTrace;
  final ErrorDisplayType errorDisplayType;
  final VoidCallback? onRetry;

  const AppError({
    this.statusCode,
    required this.message,
    this.stackTrace,
    required this.errorDisplayType,
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
      statusCode: "Error Occured ",
      message: 'Network error occurred with ${e.message}',
      stackTrace: StackTrace.current,
      errorDisplayType: errorDisplayType,
    );
  } else if (e is FormatException) {
    return AppError(
      statusCode: "Format Exception",
      message: e.message,
      stackTrace: StackTrace.current,
      errorDisplayType: errorDisplayType,
    );
  } else if (e is DioException) {
    return AppError(
      statusCode: e.response?.statusCode.toString(),
      message: 'Dio error occurred with ${e.message}',
      stackTrace: StackTrace.current,
      errorDisplayType: errorDisplayType,
    );
  } else if (e is Exception) {
    return AppError(
      statusCode: "Exception Occurred",
      message: 'Exception occurred with ${e.toString()}',
      stackTrace: StackTrace.current,
      errorDisplayType: errorDisplayType,
    );
  } else {
    return AppError(
      statusCode: "Unknown Error",
      message: 'Unknown error occurred',
      stackTrace: StackTrace.current,
      errorDisplayType: errorDisplayType,
    );
  }
}

enum ErrorDisplayType { dialog, snackbar, none }
