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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? '',

      createdAt: DateTime.tryParse(
        json['createdAt']?.toString() ?? '',
      ) ??
          DateTime.now(),

      subtotal: int.tryParse(json['subtotal'].toString()) ?? 0,
      shipping: int.tryParse(json['shipping'].toString()) ?? 0,
      total: int.tryParse(json['total'].toString()) ?? 0,

      paymentMethod: json['paymentMethod']?.toString() ?? '',

      status: json['status']?.toString() ?? 'confirmee',

      items: (json['items'] as List? ?? [])
          .map((item) =>
          CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt.toIso8601String(),
      "subtotal": subtotal,
      "shipping": shipping,
      "total": total,
      "paymentMethod": paymentMethod,
      "status": status,
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}
