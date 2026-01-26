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
  }) {
    final order = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}', // ✅ String
      createdAt: DateTime.now(),                          // ✅ DateTime
      subtotal: subtotal,                                 // ✅ requis
      shipping: shipping,                                 // ✅ requis
      total: total,                                       // ✅ requis
      paymentMethod: paymentMethod,                       // ✅ requis
      status: 'Confirmée',                                // ✅ String
      items: items,                                       // ✅ requis
    );

    _orders.insert(0, order); // dernière commande en haut
    notifyListeners();
  }
}
