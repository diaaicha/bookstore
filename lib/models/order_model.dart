import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;
  final int subtotal;
  final int shipping;
  final int total;
  final String paymentMethod;
  final String status;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.items,
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
