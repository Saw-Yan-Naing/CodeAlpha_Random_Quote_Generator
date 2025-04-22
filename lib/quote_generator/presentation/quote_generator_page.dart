import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/presentation/next_quote_btn.dart';
import '../provider/quote_provider.dart';

class QuoteGeneratorPage extends ConsumerStatefulWidget {
  const QuoteGeneratorPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuoteGeneratorPageState();
}

class _QuoteGeneratorPageState extends ConsumerState<QuoteGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    final quote = ref.watch(quoteGenerateProvider);

    return SafeArea(
      child: Scaffold(
        body: quote.when(
          data:
              (data) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data?.quote ?? 'No quote available'),
                    const SizedBox(height: 20),
                    Text(data?.author ?? 'Unknown'),
                    const SizedBox(height: 20),
                    NextQuoteBtn(
                      onPressed: () {
                        ref.invalidate(quoteGenerateProvider);
                      },
                      isLoading: quote.isLoading,
                    ),
                  ],
                ),
              ),
          loading:
              () => Center(
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.square,
                  trackGap: .9,
                ),
              ),
          error: (error, stack) {
            return Center(child: Text('Error: $error  \n $stack'));
          },
        ),
      ),
    );
  }
}
