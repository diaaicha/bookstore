import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;        // ✅ date de commande
  final int subtotal;              // ✅ sous-total
  final int shipping;              // ✅ livraison
  final int total;                 // ✅ total
  final String paymentMethod;      // ✅ mode de paiement
  final String status;             // ✅ statut
  final List<CartItemModel> items; // ✅ livres commandés
  final Map<String, String>? address; // ✅ adresse sélectionnée

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.items,
    this.address, // ⚡ peut être null si aucune adresse
  });
}
