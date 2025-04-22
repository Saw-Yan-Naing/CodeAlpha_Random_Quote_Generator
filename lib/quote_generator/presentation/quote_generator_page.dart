import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        appBar: AppBar(title: Text('Quote Generator')),
        body: quote.when(
          data: (data) => Text(data?.quote ?? 'No quote available'),
          loading: () => CircularProgressIndicator(),
          error: (error, stack) {
            return Center(child: Text('Error: $error  \n $stack'));
          },
        ),
      ),
    );
  }
}
