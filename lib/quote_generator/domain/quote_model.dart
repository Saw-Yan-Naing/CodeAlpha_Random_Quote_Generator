class QuoteModel {
  final int id;
  final String quote;
  final String author;

  QuoteModel({required this.id, required this.quote, required this.author});

  // Factory constructor to create a QuoteModel instance from JSON
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] as int,
      quote: json['quote'] as String,
      author: json['author'] as String,
    );
  }

  // Method to convert a Quote instance to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'quote': quote, 'author': author};
  }
}
