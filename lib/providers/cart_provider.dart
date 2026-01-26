import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/book_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  void addToCart(BookModel book) {
    final index = _items.indexWhere((i) => i.book.id == book.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItemModel(book: book));
    }
    notifyListeners();
  }

  void removeFromCart(int bookId) {
    _items.removeWhere((i) => i.book.id == bookId);
    notifyListeners();
  }

  void increaseQty(int bookId) {
    final item = _items.firstWhere((i) => i.book.id == bookId);
    item.quantity++;
    notifyListeners();
  }

  void decreaseQty(int bookId) {
    final item = _items.firstWhere((i) => i.book.id == bookId);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeFromCart(bookId);
    }
    notifyListeners();
  }

  int get subtotal {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get shipping {
    if (items.isEmpty) return 0;
    return 2000;
  }
  int get total => subtotal + shipping;

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
