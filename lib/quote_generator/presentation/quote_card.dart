import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  final VoidCallback? onNextQuote;
  final bool isLoading;
  final VoidCallback? shareQuote;
  
  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    this.onNextQuote,
    this.isLoading = false,
    this.shareQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(spacing: 10));
  }
}
