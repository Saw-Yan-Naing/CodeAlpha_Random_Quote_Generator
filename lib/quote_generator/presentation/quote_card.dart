import 'package:flutter/material.dart';
import 'package:random_quote_generator/core/presentation/next_quote_btn.dart';
import 'package:random_quote_generator/core/presentation/screen_size.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  final VoidCallback? nextQuote;
  final VoidCallback? onShared;
  final bool isLoading;
  final VoidCallback? shareQuote;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    this.nextQuote,
    this.onShared,
    this.isLoading = false,
    this.shareQuote,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenSize.isMobile(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 5,
      child: SizedBox(
        width: ScreenSize.getScreenWidth() * (isMobile ? 0.9 : .7),

        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '"$quote"',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'serif',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "- $author",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    NextQuoteBtn(isLoading: isLoading, onPressed: nextQuote),
                    MaterialButton(
                      height: isMobile ? 40 : 43,
                      onPressed: shareQuote,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        spacing: 15,
                        children: [
                          Icon(Icons.send_sharp, color: Colors.white, size: 20),
                          Text('Share', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
