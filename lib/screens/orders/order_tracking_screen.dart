import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/order_model.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;

  const OrderTrackingScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text('Détail de la commande'),
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
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= HEADER =================
            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORD-${order.id.substring(order.id.length - 5)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
                  _statusBadge(order.status),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= DÉTAIL COMMANDE (UNE SEULE CARD) =================
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- ARTICLES ----------
                  const Text(
                    'Articles commandés',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...order.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.book.image,
                              width: 50,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.book.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item.book.author,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Qté: ${item.quantity}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${item.book.price * item.quantity} FCFA',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  _thinDivider(),

                  // ---------- ADRESSE ----------
                  // ---------- ADRESSE ----------
                  const Text(
                    'Adresse de livraison',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (order.address == null ||
                      order.address!.isEmpty ||
                      order.address!['name'] == null ||
                      order.address!['name']!.isEmpty)
                    const Text(
                      'Aucune adresse sélectionnée',
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.address!['name'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(order.address!['street'] ?? ''),
                              Text(order.address!['city'] ?? ''),
                              Text(order.address!['phone'] ?? ''),
                            ],
                          ),
                        ),
                      ],
                    ),


                  _thinDivider(),

                  // ---------- RÉSUMÉ ----------
                  const Text(
                    'Résumé de paiement',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _priceRow('Sous-total', '${order.subtotal} FCFA'),
                  _priceRow('Livraison', '${order.shipping} FCFA'),

                  const SizedBox(height: 6),

                  _priceRow(
                    'Total',
                    '${order.total} FCFA',
                    highlight: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= TRACKING =================
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Suivi de commande',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _trackingItem(
                    title: 'Commande confirmée',
                    active: true,
                    date: '01/02/2026, 10:30',
                  ),
                  _trackingItem(
                    title: 'En préparation',
                    active: _isAtLeast('En préparation'),
                  ),
                  _trackingItem(
                    title: 'En livraison',
                    active: _isAtLeast('En livraison'),
                  ),
                  _trackingItem(
                    title: 'Livrée',
                    active: _isAtLeast('Livrée'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HELPERS =================

  bool _isAtLeast(String step) {
    const steps = [
      'Confirmée',
      'En préparation',
      'En livraison',
      'Livrée',
    ];
    return steps.indexOf(order.status) >= steps.indexOf(step);
  }

  Widget _statusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _trackingItem({
    required String title,
    bool active = false,
    String? date,
  }) {
    final Color textColor =
    active ? Colors.black : Colors.grey.shade500;

    final Color dotColor =
    active ? AppColors.primary : Colors.grey.shade500;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== CERCLE ALIGNÉ =====
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(
              Icons.circle,
              size: 10,
              color: dotColor,
            ),
          ),

          const SizedBox(width: 12),

          // ===== TEXTE =====
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // 👈 TOUJOURS EN GRAS
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date ?? 'En attente',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _priceRow(String label, String value,
      {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight:
              highlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight:
              highlight ? FontWeight.bold : FontWeight.normal,
              color:
              highlight ? AppColors.primary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _thinDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Divider(
        height: 1,
        thickness: 0.6,
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: child,
    );
  }
}
