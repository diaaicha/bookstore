import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  void createOrder({
    required List<CartItemModel> items,
    required int subtotal,
    required int shipping,
    required int total,
    required String paymentMethod,
    required Map<String, String>? address, // ✅ AJOUTÉ
  }) {
    final order = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      subtotal: subtotal,
      shipping: shipping,
      total: total,
      paymentMethod: paymentMethod,
      status: 'Confirmée',
      items: items,
      address: address, // ✅ AJOUTÉ
    );

    _orders.insert(0, order);
    notifyListeners();
  }
}
