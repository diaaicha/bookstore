import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/order_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text('Mes commandes'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (index == 1) Navigator.pushNamed(context, AppRoutes.books);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.cart);
          if (index == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),

      // ================= BODY =================
      body: orders.isEmpty
          ? _emptyOrders()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return Material(
            color: Colors.transparent, // 🔴 IMPORTANT
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= HAUT =================
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ORD-${order.id.substring(order.id.length - 5)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.createdAt.day.toString().padLeft(2, '0')}/'
                                '${order.createdAt.month.toString().padLeft(2, '0')}/'
                                '${order.createdAt.year}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      // ================= STATUT =================
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _statusBg(order.status),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          order.status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color:
                            _statusColor(order.status),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ================= SEPARATEUR =================
                  Divider(
                    height: 1,
                    thickness: 0.6,
                    color: Colors.grey.shade300,
                  ),

                  const SizedBox(height: 8),

                  // ================= BAS =================
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${order.items.length} livre(s)',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.total} FCFA',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      // ================= VOIR DÉTAILS =================
                      InkWell(
                        borderRadius:
                        BorderRadius.circular(6),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.orderTracking,
                            arguments: order,
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          child: Text(
                            'Voir détails',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= EMPTY STATE =================
  Widget _emptyOrders() {
    return const Center(
      child: Text(
        'Aucune commande pour le moment',
        style: TextStyle(
          fontSize: 15,
          color: AppColors.gray500,
        ),
      ),
    );
  }

  // ================= STATUS COLORS =================
  Color _statusColor(String status) {
    switch (status) {
      case 'Confirmée':
        return Colors.green;
      case 'En préparation':
        return Colors.orange;
      case 'En livraison':
        return Colors.blue;
      case 'Livrée':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _statusBg(String status) {
    switch (status) {
      case 'Confirmée':
        return Colors.green.withOpacity(0.12);
      case 'En préparation':
        return Colors.orange.withOpacity(0.12);
      case 'En livraison':
        return Colors.blue.withOpacity(0.12);
      case 'Livrée':
        return Colors.purple.withOpacity(0.12);
      default:
        return Colors.grey.withOpacity(0.12);
    }
  }
}
