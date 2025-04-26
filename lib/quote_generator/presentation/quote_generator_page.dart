import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_quote_generator/quote_generator/domain/assets_image.dart';
import 'package:random_quote_generator/quote_generator/presentation/quote_card.dart';

import '../provider/quote_provider.dart';

class QuoteGeneratorPage extends ConsumerStatefulWidget {
  const QuoteGeneratorPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuoteGeneratorPageState();
}

class _QuoteGeneratorPageState extends ConsumerState<QuoteGeneratorPage> {
  final GlobalKey _shareKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final quote = ref.watch(quoteGenerateProvider);
    final func = ref.read(quoteGenerateProvider.notifier);
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
                            child: Column(
                              spacing: 30,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  MySvg.logo,
                                  height: 70,
                                  width: 70,
                                ),
                                Text(
                                  'No Quote Available',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'serif',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
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
                              SvgPicture.asset(
                                MySvg.logo,
                                height: 70,
                                width: 70,
                              ),
                              Text(
                                "Quote of the Day",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              RepaintBoundary(
                                key: _shareKey,
                                child: QuoteCard(
                                  quote: data.quote,
                                  author: data.author,
                                  nextQuote: () {
                                    ref.invalidate(quoteGenerateProvider);
                                  },
                                  shareQuote:
                                      () =>
                                          func.shareQuote(shareKey: _shareKey),
                                  isLoading: quote.isLoading,
                                ),
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
