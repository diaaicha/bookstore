import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';
import '../../models/order_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentMethod = 'mobile';
  Map<String, String>? selectedAddress;

  @override
  void initState() {
    super.initState();
    _loadSelectedAddress();
  }

  // Charge l'adresse sélectionnée (si sauvegardée) ou la première adresse disponible
  Future<void> _loadSelectedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selected_address');

    if (saved != null) {
      setState(() {
        selectedAddress = Map<String, String>.from(json.decode(saved));
      });
    } else {
      // Récupère la première adresse disponible
      final firstAddress = await _getFirstAvailableAddress();
      if (firstAddress != null) {
        _saveSelectedAddress(firstAddress);
      }
    }
  }

  // Sauvegarde l'adresse sélectionnée
  Future<void> _saveSelectedAddress(Map<String, String> addr) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_address', json.encode(addr));
    setState(() {
      selectedAddress = addr;
    });
  }

  // Exemple de récupération de la première adresse
  Future<Map<String, String>?> _getFirstAvailableAddress() async {
    // Ici tu peux récupérer depuis ton provider ou ta liste d'adresses
    // Pour l'exemple, on renvoie une adresse fixe
    return {
      'name': 'Yarame Diakhate',
      'street': '123 Rue Exemple',
      'city': 'Saint Louis',
      'phone': '77 123 45 67',
    };
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Paiement'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (index == 1) Navigator.pushNamed(context, AppRoutes.books);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),
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
              onPressed: cart.items.isEmpty || selectedAddress == null
                  ? null
                  : () {
                final order = OrderModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  createdAt: DateTime.now(),
                  subtotal: cart.subtotal,
                  shipping: cart.items.isEmpty ? 0 : 2000,
                  total: cart.total,
                  paymentMethod: paymentMethod,
                  status: 'Confirmée',
                  items: cart.items,
                  address: selectedAddress,
                );

                context.read<OrderProvider>().createOrder(
                  items: List.from(order.items),
                  subtotal: order.subtotal,
                  shipping: order.shipping,
                  total: order.total,
                  paymentMethod: order.paymentMethod,
                  address: order.address, // ✅ IMPORTANT
                );


                context.read<CartProvider>().clearCart();

                Navigator.pushNamed(
                  context,
                  AppRoutes.orderDetail,
                  arguments: order,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(
              'Adresse de livraison',
              action: 'Modifier',
              onTap: () async {
                final result =
                await Navigator.pushNamed(context, AppRoutes.address);
                if (result != null && result is Map<String, String>) {
                  _saveSelectedAddress(result);
                }
              },
            ),
            _card(
              child: selectedAddress == null
                  ? const Text('Aucune adresse sélectionnée')
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        selectedAddress!['name']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(selectedAddress!['street']!),
                  Text(selectedAddress!['city']!),
                  const SizedBox(height: 4),
                  Text(selectedAddress!['phone']!),
                ],
              ),
            ),
            const SizedBox(height: 24),
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

  Widget _sectionTitle(String title, {String? action, VoidCallback? onTap}) {
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
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gray500,
                      )),
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
          Text(label,
              style:
              TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  color: highlight ? AppColors.primary : Colors.black)),
        ],
      ),
    );
  }
}
