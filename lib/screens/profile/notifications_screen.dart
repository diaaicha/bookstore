import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Simule des notifications dynamiques
  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'icon': Icons.check_circle,
        'iconColor': Colors.green,
        'bgColor': Colors.green[100],
        'title': 'Commande livrée',
        'subtitle': 'Votre commande #ORD-12345 a été livrée avec succès',
        'time': 'Il y a 2 heures',
      },
      {
        'icon': Icons.local_shipping,
        'iconColor': AppColors.primary,
        'bgColor': Colors.orange[100],
        'title': 'Commande en cours de livraison',
        'subtitle': 'Votre commande #ORD-12344 est en cours de livraison',
        'time': 'Il y a 5 heures',
      },
      {
        'icon': Icons.sell,
        'iconColor': Colors.red,
        'bgColor': Colors.red[100],
        'title': 'Nouvelle promotion',
        'subtitle': 'Profitez de -30% sur les livres Business',
        'time': 'Hier',
      },
      {
        'icon': Icons.star,
        'iconColor': Colors.blue,
        'bgColor': Colors.blue[100],
        'title': 'Nouveaux livres',
        'subtitle': 'Nouvelle collection informatique disponible',
        'time': 'Il y a 2 jours',
      },
    ];
  }

  void _onBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.books); // Catégories
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.cart);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Notifications'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.profile),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNotifications(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: notif['bgColor'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notif['icon'],
                        color: notif['iconColor'],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notif['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notif['subtitle'],
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notif['time'],
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      // =================== BOTTOM NAV ===================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, // Profil actif
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onBottomNavTap(context, index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view), label: 'Catégories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Panier'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
