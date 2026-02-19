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

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: int.parse(json['id'].toString()),
      title: json['title']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
      price: int.parse(json['price'].toString()),
      oldPrice: json['oldPrice'] != null
          ? int.tryParse(json['oldPrice'].toString())
          : null,
      discount: json['discount'] != null
          ? int.tryParse(json['discount'].toString())
          : null,
      image: json['image']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      reviews: int.tryParse(json['reviews'].toString()) ?? 0,
      description: json['description']?.toString() ?? '',
      publisher: json['publisher']?.toString() ?? '',
      pages: int.tryParse(json['pages'].toString()) ?? 0,
      isbn: json['isbn']?.toString() ?? '',
      inStock: json['inStock'] == true ||
          json['inStock'] == 1 ||
          json['inStock'] == "1",
      releaseDate: DateTime.tryParse(
          json['releaseDate']?.toString() ?? '')
          ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "author": author,
      "price": price,
      "oldPrice": oldPrice,
      "discount": discount,
      "image": image,
      "category": category,
      "rating": rating,
      "reviews": reviews,
      "description": description,
      "publisher": publisher,
      "pages": pages,
      "isbn": isbn,
      "inStock": inStock ? 1 : 0,
      "releaseDate": releaseDate.toIso8601String(),
    };
  }
}
