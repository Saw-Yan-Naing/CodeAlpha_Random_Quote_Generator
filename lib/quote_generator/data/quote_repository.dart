import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dio_service/dio_service.dart';
import '../../core/error/app_error_catching.dart';
import '../domain/quote_model.dart';

abstract class QuoteRepository {
  Future<Result<QuoteModel>> getRandomQuote();
}

class QuoteRepositoryImpl implements QuoteRepository {
  final Ref ref;

  const QuoteRepositoryImpl(this.ref);

  @override
  Future<Result<QuoteModel>> getRandomQuote() async {
    try {
      final dioService = ref.read(dioServiceProvider);
      final response = await dioService.getApi('random');

      final data = response.data;
      final quoteModel = QuoteModel.fromJson(data);
      return Result.success(quoteModel);
    } catch (e) {
      return Result.failure(getError(e));
    }
  }
}

final quoteRepositoryProvider = Provider<QuoteRepository>((ref) {
  return QuoteRepositoryImpl(ref);
});

final getQuoteProvider = FutureProvider.autoDispose<Result<QuoteModel>>((
  ref,
) async {
  final quoteRepository = ref.watch(quoteRepositoryProvider);
  final result = await quoteRepository.getRandomQuote();
  return result;
});
