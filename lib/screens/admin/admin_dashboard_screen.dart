import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../providers/book_provider.dart';
import 'admin_orders_screen.dart';
import 'admin_books_screen.dart';
import 'admin_users_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final bookProvider = context.watch<BookProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Administration"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Vue d'ensemble",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.gray700,
              ),
            ),

            const SizedBox(height: AppSizes.paddingM),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppSizes.paddingM,
              mainAxisSpacing: AppSizes.paddingM,
              children: [

                _statCard(
                  "Livres",
                  bookProvider.totalBooks.toString(),
                  Icons.menu_book,
                  AppColors.secondary,
                ),

                _statCard(
                  "Commandes",
                  "0",
                  Icons.shopping_bag,
                  AppColors.blue,
                ),

                _statCard(
                  "Utilisateurs",
                  "0",
                  Icons.people,
                  AppColors.primary,
                ),

                _statCard(
                  "Revenus",
                  "0 FCFA",
                  Icons.attach_money,
                  AppColors.green,
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingL),

            const Text(
              "Gestion",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.gray700,
              ),
            ),

            const SizedBox(height: AppSizes.paddingM),

            _actionButton(
              "Gérer les livres",
              Icons.menu_book,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminBooksScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSizes.paddingM),

            _actionButton(
              "Gérer les commandes",
              Icons.shopping_cart,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminOrdersScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSizes.paddingM),

            _actionButton(
              "Gérer les utilisateurs",
              Icons.people,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminUsersScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
      String title,
      String value,
      IconData icon,
      Color color) {

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
        BorderRadius.circular(AppSizes.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200,
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.gray700,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.gray500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      String title,
      IconData icon,
      VoidCallback onTap) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.all(AppSizes.paddingM),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius:
          BorderRadius.circular(AppSizes.radiusM),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray200,
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: AppSizes.paddingM),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.gray700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
