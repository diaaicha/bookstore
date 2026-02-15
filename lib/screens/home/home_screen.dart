import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/book_provider.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cards/book_card.dart';
import '../../widgets/inputs/search_field.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    final cartProvider = context.read<CartProvider>();
    final books = bookProvider.filteredBooks;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= BOTTOM NAVBAR =================
      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, AppRoutes.books);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.cart);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),

      body: CustomScrollView(
        slivers: [

          // ================= HEADER =================
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'BookStore',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.notifications,
                          );
                        },
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SearchField(
                    onChanged: bookProvider.setSearchQuery,
                  ),
                ],
              ),
            ),
          ),

          // ================= PROMO =================
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Soldes d\'été 🔥',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Jusqu\'à -50% sur une sélection',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.books);
                      },
                      child: const Text('Voir les offres'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ================= TITRE CATEGORIES =================
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Catégories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ================= CATEGORIES =================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final c = _categoriesData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.books);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1E6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            c['icon'] as IconData,
                            color: AppColors.primary,
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c['label'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: _categoriesData.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
            ),
          ),

          // ================= TITRE LIVRES + VOIR TOUT =================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    books.isEmpty
                        ? 'Aucun livre trouvé'
                        : 'Livres populaires',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (books.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.books);
                      },
                      child: const Text(
                        'Voir tout',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ================= GRID LIVRES =================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final book = books[index];
                  return BookCard(
                    book: book,
                    onTap: () {
                      bookProvider.selectBook(book);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.bookDetail,
                      );
                    },
                    onAdd: () {
                      cartProvider.addToCart(book);
                    },
                  );
                },
                childCount: books.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.62,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }
}

// ================= CATEGORIES DATA =================
final List<Map<String, dynamic>> _categoriesData = [
  {'icon': Icons.menu_book, 'label': 'Scolaire'},
  {'icon': Icons.computer, 'label': 'Informatique'},
  {'icon': Icons.favorite, 'label': 'Romans'},
  {'icon': Icons.business_center, 'label': 'Business'},
  {'icon': Icons.account_balance, 'label': 'Religion'},
  {'icon': Icons.science, 'label': 'Sciences'},
  {'icon': Icons.child_care, 'label': 'Enfants'},
  {'icon': Icons.more_horiz, 'label': 'Plus'},
];
