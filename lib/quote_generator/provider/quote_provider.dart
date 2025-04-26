import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_quote_generator/core/error/error_provider.dart';
import 'package:random_quote_generator/quote_generator/domain/quote_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/error/app_error_catching.dart';
import '../data/quote_repository.dart';

class QuoteGenerateProvider extends AsyncNotifier<QuoteModel?> {
  @override
  FutureOr<QuoteModel?> build() async {
    final quote = await ref.read(getQuoteProvider.future);

    if (!quote.isSuccess) {
      ref
          .read(errorProvider)
          .showError(
            quote.error ??
                AppError(
                  statusCode: quote.error?.statusCode ?? 500.toString(),
                  message: 'An error occurred while fetching the quote.',
                  stackTrace: quote.error?.stackTrace,
                  errorDisplayType: ErrorDisplayType.dialog,
                ),
          );
    }

    return quote.data;
  }

  Future<void> shareQuote({required GlobalKey shareKey}) async {
    try {
      RenderRepaintBoundary boundary =
          shareKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/quote.png').create();
      await file.writeAsBytes(pngBytes);

      final shareResult = await SharePlus.instance.share(
        ShareParams(
          text: 'Check out this quote!',
          files: [XFile(file.path)],
          subject: 'Quote of the Day',
        ),
      );

      debugPrint('Share result: ${shareResult.status} ${shareResult.raw}');
    } catch (e) {
      ref
          .read(errorProvider)
          .showError(
            AppError(
              message: e.toString(),
              stackTrace: StackTrace.current,
              errorDisplayType: ErrorDisplayType.dialog,
            ),
          );
    }
  }
}

final quoteGenerateProvider =
    AsyncNotifierProvider<QuoteGenerateProvider, QuoteModel?>(
      () => QuoteGenerateProvider(),
    );
