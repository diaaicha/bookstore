import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';
import '../../widgets/cards/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes commandes')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (_, i) => OrderCard(
          order: orders[i],
          onTap: () {},
        ),
      ),
    );
  }
}
