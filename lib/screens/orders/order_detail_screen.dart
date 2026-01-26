import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../models/order_model.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
                  (_) => false,
            );
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // ✅ ICÔNE SUCCÈS
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.15),
              ),
              child: const Icon(
                Icons.check_circle,
                size: 70,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Commande confirmée !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Votre commande a été passée avec succès',
              style: TextStyle(color: AppColors.gray500),
            ),

            const SizedBox(height: 10),

            Text(
              'Numéro de commande : ${order.id}',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            // ================= DÉTAILS =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Détails de la commande',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _row('Date',
                      '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}'),
                  _row('Montant total', '${order.total} FCFA'),
                  _row('Mode de paiement', order.paymentMethod),
                  _row(
                    'Statut',
                    order.status,
                    highlight: true,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ================= BOUTONS =================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.orders);
                },
                child: const Text(
                  'Suivre ma commande',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                        (_) => false,
                  );
                },
                child: const Text(
                  'Continuer les achats',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value,
      {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
              highlight ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
