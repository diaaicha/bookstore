import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentMethod = 'mobile';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text('Paiement'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (index == 1) Navigator.pushNamed(context, AppRoutes.books);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),

      // ================= BOUTON FIXE =================
      bottomSheet: SafeArea(
        child: Container(
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
              onPressed: cart.items.isEmpty
                  ? null
                  : () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.orderDetail,
                  
                );
              },
              child: const Text(
                'Confirmer le paiement',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= ADRESSE =================
            _sectionTitle(
              'Adresse de livraison',
              action: 'Modifier',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.address);
              },
            ),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.primary),
                      SizedBox(width: 6),
                      Text(
                        'Jean Kouassi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Cocody, Angré 8ème Tranche'),
                  Text('Abidjan, Côte d’Ivoire'),
                  SizedBox(height: 4),
                  Text('+225 07 XX XX XX XX'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ================= MODE DE PAIEMENT =================
            _sectionTitle(
              'Mode de paiement',
              action: '+ Ajouter',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.addPaymentMethod,
                );
              },
            ),

            _paymentOption(
              value: 'mobile',
              icon: Icons.phone_android,
              title: 'Mobile Money',
              subtitle: 'Orange Money, MTN, Moov',
            ),

            const SizedBox(height: 12),

            _paymentOption(
              value: 'card',
              icon: Icons.credit_card,
              title: 'Carte bancaire',
              subtitle: 'Visa, Mastercard',
            ),

            const SizedBox(height: 24),

            // ================= RÉCAP =================
            _sectionTitle('Récapitulatif'),

            _card(
              child: Column(
                children: [
                  ...cart.items.map((item) {
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Qté: ${item.quantity}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.gray500,
                                  ),
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
                  }),

                  const Divider(),

                  _priceRow('Sous-total', '${cart.subtotal} FCFA'),
                  _priceRow(
                    'Livraison',
                    cart.items.isEmpty ? '0 FCFA' : '2 000 FCFA',
                  ),
                  const SizedBox(height: 6),
                  _priceRow(
                    'Total',
                    '${cart.total} FCFA',
                    bold: true,
                    highlight: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= COMPONENTS =================

  Widget _sectionTitle(String title,
      {String? action, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (action != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                action,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
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

  Widget _paymentOption({
    required String value,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final selected = paymentMethod == value;

    return GestureDetector(
      onTap: () => setState(() => paymentMethod = value),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.gray200,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: paymentMethod,
              onChanged: (v) => setState(() => paymentMethod = v!),
              activeColor: AppColors.primary,
            ),
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value,
      {bool bold = false, bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: highlight ? AppColors.primary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
