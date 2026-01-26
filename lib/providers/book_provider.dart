import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookProvider with ChangeNotifier {
  List<BookModel> _books = [];
  BookModel? _selectedBook;
  String _searchQuery = '';

  BookProvider() {
    _loadMockBooks();
  }

  List<BookModel> get books => _books;
  BookModel? get selectedBook => _selectedBook;

  // ================= MOCK DATA =================
  void _loadMockBooks() {
    _books = [
      BookModel(
        id: 1,
        title: 'Atomic Habits',
        author: 'James Clear',
        price: 15000,
        oldPrice: 20000,
        discount: 25,
        image: 'assets/images/atomic_habits.jpg',
        category: 'Business',
        rating: 4.8,
        reviews: 1200,
        description:
        'Un guide pratique pour construire de bonnes habitudes et briser les mauvaises.',
        publisher: 'Penguin Random House',
        pages: 320,
        isbn: '9780735211292',
        inStock: true,
        releaseDate: DateTime(2018, 10, 16),
      ),
      BookModel(
        id: 2,
        title: 'Python Programming',
        author: 'John Smith',
        price: 18000,
        image: 'assets/images/python.jpg',
        category: 'Informatique',
        rating: 4.5,
        reviews: 850,
        description:
        'Apprenez Python étape par étape avec des exemples pratiques.',
        publisher: 'O\'Reilly Media',
        pages: 450,
        isbn: '9781492051367',
        inStock: true,
        releaseDate: DateTime(2020, 5, 20),
      ),
      BookModel(
        id: 3,
        title: 'Rich Dad Poor Dad',
        author: 'Robert Kiyosaki',
        price: 12000,
        oldPrice: 14000,
        discount: 15,
        image: 'assets/images/rich_dad.jpg',
        category: 'Business',
        rating: 4.6,
        reviews: 980,
        description:
        'Un livre culte sur l’éducation financière et l’indépendance.',
        publisher: 'Plata Publishing',
        pages: 336,
        isbn: '9781612680194',
        inStock: true,
        releaseDate: DateTime(2017, 4, 11),
      ),
      BookModel(
        id: 4,
        title: 'The Little Prince',
        author: 'Antoine de Saint-Exupéry',
        price: 8000,
        image: 'assets/images/little_prince.jpg',
        category: 'Romans',
        rating: 4.9,
        reviews: 2100,
        description:
        'Un classique intemporel de la littérature mondiale.',
        publisher: 'Gallimard',
        pages: 96,
        isbn: '9782070612758',
        inStock: true,
        releaseDate: DateTime(1943, 4, 6),
      ),
    ];

    notifyListeners();
  }

  // ================= SELECTION =================
  void selectBook(BookModel book) {
    _selectedBook = book;
    notifyListeners();
  }

  // ================= SEARCH =================
  void setSearchQuery(String value) {
    _searchQuery = value.toLowerCase();
    notifyListeners();
  }

  List<BookModel> get filteredBooks {
    if (_searchQuery.isEmpty) return _books;

    return _books.where((b) {
      return b.title.toLowerCase().contains(_searchQuery) ||
          b.author.toLowerCase().contains(_searchQuery);
    }).toList();
  }
}
