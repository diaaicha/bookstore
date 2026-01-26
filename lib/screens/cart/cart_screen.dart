import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text('Mon Panier (${cart.items.length})'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (_) {},
      ),

      body: cart.items.isEmpty
          ? _emptyCart()
          : Column(
        children: [
          // ================= LISTE DES PRODUITS =================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
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
                      // IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.book.image,
                          width: 70,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // INFOS
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.book.author,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.gray500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${item.book.price} FCFA',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ACTIONS À DROITE
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // SUPPRIMER
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            color: Colors.red,
                            onPressed: () {
                              cart.removeFromCart(item.book.id);
                            },
                          ),

                          const SizedBox(height: 6),

                          // QUANTITÉ
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.gray200,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  constraints:
                                  const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.remove, size: 18),
                                  onPressed: () {
                                    cart.decreaseQty(item.book.id);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  constraints:
                                  const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.add, size: 18),
                                  onPressed: () {
                                    cart.increaseQty(item.book.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ================= RÉCAP (BLANC) =================
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  _priceRow(
                    'Sous-total',
                    '${cart.subtotal} FCFA',
                  ),
                  const SizedBox(height: 6),
                  _priceRow(
                    'Livraison',
                    cart.items.isEmpty ? '0 FCFA' : '2 000 FCFA',
                  ),
                  const Divider(height: 24),
                  _priceRow(
                    'Total',
                    '${cart.total} FCFA',
                    bold: true,
                    highlight: true,
                  ),
                  const SizedBox(height: 16),

                  // BOUTON COMMANDE
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.payment);
                      },
                      child: const Text(
                        'Passer à la commande',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= PANIER VIDE =================
  Widget _emptyCart() {
    return const Center(
      child: Text(
        'Votre panier est vide',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.gray500,
        ),
      ),
    );
  }

  // ================= LIGNE PRIX =================
  Widget _priceRow(
      String label,
      String value, {
        bool bold = false,
        bool highlight = false,
      }) {
    return Row(
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
    );
  }
}
