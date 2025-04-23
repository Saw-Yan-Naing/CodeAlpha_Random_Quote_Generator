import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/quote_generator/presentation/quote_card.dart';

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
        body: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: quote.when(
            data:
                (data) =>
                    data == null
                        ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              'No Quote Available',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'serif',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        )
                        : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Text(
                                "Quote of the Day",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              QuoteCard(
                                quote: data.quote,
                                author: data.author,

                                nextQuote: () {
                                  ref.invalidate(quoteGenerateProvider);
                                },
                                shareQuote: () {},
                                isLoading: quote.isLoading,
                              ),
                            ],
                          ),
                        ),
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
