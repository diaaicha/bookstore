import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final orders = context.watch<OrderProvider>().orders;
    final favorites = context.watch<FavoriteProvider>().favorites;

    final totalOrders = orders.length;
    final inProgress =
        orders.where((o) => o.status != 'Confirmée').length;
    final purchasedBooks = orders.fold<int>(
      0,
          (sum, o) => sum + o.items.length,
    );

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (index == 1) Navigator.pushNamed(context, AppRoutes.categories);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.cart);
        },
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Mon Profil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // USER INFO
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auth.userName ?? 'Jean Kouassi',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            auth.email ?? 'diacha3108@gmail.com',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const Text(
                            '+225 07 XX XX XX XX',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= STATS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statCard('Commandes', totalOrders),
                  _statCard('En cours', inProgress),
                  _statCard('Livres achetés', purchasedBooks),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= MENU =================
            _menuSection([
              _menuItem(
                icon: Icons.receipt_long,
                label: 'Mes commandes',
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.orders),
              ),
              _menuItem(
                icon: Icons.favorite_border,
                label: 'Mes favoris',
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
              ),
              _menuItem(
                icon: Icons.location_on_outlined,
                label: 'Adresses de livraison',
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.address),
              ),
            ]),

            _menuSection([
              _menuItem(
                icon: Icons.credit_card,
                label: 'Moyens de paiement',
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.addPaymentMethod,
                ),
              ),
              _menuItem(
                icon: Icons.notifications_none,
                label: 'Notifications',
                onTap: () {},
              ),
              _menuItem(
                icon: Icons.help_outline,
                label: 'Aide & Support',
                onTap: () {},
              ),
            ]),

            _menuSection([
              _menuItem(
                icon: Icons.info_outline,
                label: 'À propos',
                onTap: () {},
              ),
              _menuItem(
                icon: Icons.logout,
                label: 'Se déconnecter',
                color: Colors.red,
                onTap: () {
                  auth.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.auth,
                        (_) => false,
                  );
                },
              ),
            ]),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ================= COMPONENTS =================

  Widget _statCard(String label, int value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
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
        child: Column(
          children: [
            Text(
              '$value',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuSection(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
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
        child: Column(children: children),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = AppColors.primary,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color == Colors.red ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
