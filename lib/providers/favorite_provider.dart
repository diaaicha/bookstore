import 'package:flutter/material.dart';
import '../models/book_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<BookModel> _favorites = [];

  List<BookModel> get favorites => _favorites;

  /// ✅ Vérifie si un livre est en favori
  bool isFavorite(int bookId) {
    return _favorites.any((b) => b.id == bookId);
  }

  /// ✅ Ajoute ou supprime un favori
  void toggle(BookModel book) {
    final index = _favorites.indexWhere((b) => b.id == book.id);

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(book);
    }

    notifyListeners();
  }

  /// (optionnel) supprimer explicitement
  void remove(int bookId) {
    _favorites.removeWhere((b) => b.id == bookId);
    notifyListeners();
  }

  /// (optionnel) vider les favoris
  void clear() {
    _favorites.clear();
    notifyListeners();
  }
}
