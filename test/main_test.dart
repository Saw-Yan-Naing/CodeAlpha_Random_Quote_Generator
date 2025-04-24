import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/error/app_error_catching.dart';
import 'package:random_quote_generator/quote_generator/data/quote_repository.dart';
import 'package:random_quote_generator/quote_generator/domain/quote_model.dart';

import 'core/mock_repository.dart';

void main() {
  test('fetchQuote returns a QuoteModel when API call is successful', () async {
    final container = ProviderContainer(
      overrides: [
        quoteRepositoryProvider.overrideWithValue(MockQuoteRepository()),
      ],
    );
    addTearDown(container.dispose);

    final quote = await container.read(getQuoteProvider.future);

    expect(quote, isA<Result<QuoteModel>>());
    expect(quote.data?.quote, isNotEmpty);
    expect(quote.data?.author, isNotEmpty);
  });
}
