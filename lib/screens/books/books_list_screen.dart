import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/book_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final books = context.watch<BookProvider>().filteredBooks;
    final cart = context.read<CartProvider>();
    final favorites = context.watch<FavoriteProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= FOOTER =================
      bottomNavigationBar: BottomNavbar(
        currentIndex: 1, // Catégories / Livres
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
          if (index == 2) {
            Navigator.pushReplacementNamed(context, AppRoutes.cart);
          }
          if (index == 3) {
            Navigator.pushReplacementNamed(context, AppRoutes.profile);
          }
        },
      ),

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Tous les livres'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.filter_list),
          ),
        ],
      ),

      body: Column(
        children: [
          // ================= FILTRES =================
          SizedBox(
            height: 48,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                _filterChip('Populaires', selected: true),
                _filterChip('Prix croissant'),
                _filterChip('Prix décroissant'),
                _filterChip('Nouveautés'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ================= LISTE LIVRES =================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final isFav = favorites.isFavorite(book.id);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          book.image,
                          width: 80,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // INFOS
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TITRE + FAVORI
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    book.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFav
                                        ? Colors.red
                                        : AppColors.gray400,
                                  ),
                                  onPressed: () {
                                    favorites.toggle(book);
                                  },
                                ),
                              ],
                            ),

                            Text(
                              book.author,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.gray500,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // NOTE
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${book.rating}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            // PRIX + AJOUTER
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${book.price} FCFA',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (book.oldPrice != null)
                                      Text(
                                        '${book.oldPrice} FCFA',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.gray400,
                                          decoration:
                                          TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    cart.addToCart(book);
                                  },
                                  child: const Text(
                                    'Ajouter',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= FILTRE CHIP =================
  Widget _filterChip(String label, {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.gray100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : AppColors.gray700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }





}
