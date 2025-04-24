import 'package:random_quote_generator/core/error/app_error_catching.dart';
import 'package:random_quote_generator/quote_generator/data/quote_repository.dart';
import 'package:random_quote_generator/quote_generator/domain/quote_model.dart';

class MockQuoteRepository implements QuoteRepository {
  @override
  Future<Result<QuoteModel>> getRandomQuote() {
    // Simulate a successful API response
    final quoteModel = QuoteModel(
      id: 1,
      quote: 'This is a test quote.',
      author: 'Test Author',
    );
    return Future.value(Result.success(quoteModel));
  }
}
