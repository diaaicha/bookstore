import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/book_provider.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final book = context.watch<BookProvider>().selectedBook!;
    final cart = context.read<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (index == 1) Navigator.pushNamed(context, AppRoutes.books);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.cart);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),

      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () {
              cart.addToCart(book);
            },
            child: const Text(
              'Ajouter au panier',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ===== IMAGE CARD =====
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    book.image,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== TITLE =====
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              book.author,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray500,
              ),
            ),

            const SizedBox(height: 12),

            // ===== PRICE =====
            Row(
              children: [
                Text(
                  '${book.price} FCFA',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                if (book.oldPrice != null)
                  Text(
                    '${book.oldPrice} FCFA',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.gray400,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              book.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray700,
              ),
            ),

            const SizedBox(height: 24),

            // ===== EXTRA FEATURES =====
            _infoRow(Icons.menu_book, 'Catégorie', book.category ?? 'Général'),
            const SizedBox(height: 10),
            _infoRow(Icons.language, 'Langue', 'Français'),
            const SizedBox(height: 10),
            _infoRow(Icons.star, 'Note', '4.8 / 5'),

          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          '$label : ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(value),
      ],
    );
  }
}
