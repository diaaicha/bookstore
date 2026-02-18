import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../providers/book_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart'; // ✅ ajouter
import '../../widgets/inputs/search_field.dart';
import '../../widgets/cards/book_card.dart';
import '../../core/routes/app_routes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    final cartProvider = context.read<CartProvider>();
    final favoriteProvider = context.watch<FavoriteProvider>(); // ✅ ajouter

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Recherche',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary,
            child: SearchField(
              onChanged: bookProvider.setSearchQuery,
            ),
          ),

          // 📚 RESULTS
          Expanded(
            child: Builder(
              builder: (_) {
                final books = bookProvider.filteredBooks;

                if (books.isEmpty) {
                  return const _EmptySearchState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    final isFavorite = favoriteProvider.isFavorite(book.id); // ✅

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BookCard(
                        book: book,

                        onAdd: () {
                          cartProvider.addToCart(book);
                        },

                        onTap: () {
                          bookProvider.selectBook(book);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.bookDetail,
                          );
                        },

                        // ✅ FAVORIS
                        isFavorite: isFavorite,
                        onFavorite: () {
                          favoriteProvider.toggle(book);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 🟦 EMPTY STATE
class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search_off,
              size: 80,
              color: AppColors.gray400,
            ),
            SizedBox(height: 16),
            Text(
              'Aucun résultat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.gray700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Essayez avec un autre mot-clé',
              style: TextStyle(
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
