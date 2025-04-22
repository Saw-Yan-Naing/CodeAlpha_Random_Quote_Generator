import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/error/error_provider.dart';
import 'package:random_quote_generator/quote_generator/domain/quote_model.dart';

import '../../core/error/app_error_catching.dart';
import '../data/quote_repository.dart';

class QuoteGenerateProvider extends AsyncNotifier<QuoteModel?> {
  @override
  FutureOr<QuoteModel?> build() async {
    final quote = await ref.read(getQuoteProvider.future);

    if (!quote.isSuccess) {
      print(
        "QuoteGenerateProvider: ${quote.error?.stackTrace} \n ${quote.error?.message} \n ${quote.error?.errorDisplayType}",
      );
      ref
          .read(errorProvider)
          .showError(
            quote.error ??
                AppError("", StackTrace.current, ErrorDisplayType.none),
          );
    }

    return quote.data;
  }
}

final quoteGenerateProvider =
    AsyncNotifierProvider<QuoteGenerateProvider, QuoteModel?>(
      () => QuoteGenerateProvider(),
    );
