import 'book_model.dart';

class CartItemModel {
  final BookModel book;
  int quantity;

  CartItemModel({
    required this.book,
    this.quantity = 1,
  });

  /// 🔹 Prix total pour cet item
  int get totalPrice => book.price * quantity;

  /// 🔹 JSON → CartItemModel
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      book: BookModel.fromJson(
        json['book'] as Map<String, dynamic>,
      ),
      quantity: int.tryParse(json['quantity'].toString()) ?? 1,
    );
  }

  /// 🔹 CartItemModel → JSON
  Map<String, dynamic> toJson() {
    return {
      "book": book.toJson(),
      "quantity": quantity,
    };
  }

  /// 🔹 Modifier quantité facilement
  CartItemModel copyWith({
    BookModel? book,
    int? quantity,
  }) {
    return CartItemModel(
      book: book ?? this.book,
      quantity: quantity ?? this.quantity,
    );
  }
}
