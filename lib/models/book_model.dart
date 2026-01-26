class BookModel {
  final int id;
  final String title;
  final String author;
  final int price;
  final int? oldPrice;
  final int? discount;
  final String image;
  final String category;
  final double rating;
  final int reviews;
  final String description;
  final String publisher;
  final int pages;
  final String isbn;
  final bool inStock;
  final DateTime releaseDate;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    this.oldPrice,
    this.discount,
    required this.image,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.publisher,
    required this.pages,
    required this.isbn,
    required this.inStock,
    required this.releaseDate,
  });
}
