import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../models/order_model.dart';
import '../../services/api_services.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() =>
      _AdminOrdersScreenState();
}

class _AdminOrdersScreenState
    extends State<AdminOrdersScreen> {

  late Future<List<OrderModel>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = ApiService.getOrders();
  }

  void _refresh() {
    setState(() {
      futureOrders = ApiService.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Gestion des commandes"),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: futureOrders,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          final orders = snapshot.data!;

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "Aucune commande",
                style: TextStyle(
                  color: AppColors.gray500,
                ),
              ),
            );
          }

          return ListView.builder(
            padding:
            const EdgeInsets.all(AppSizes.paddingM),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _orderCard(order);
            },
          );
        },
      ),
    );
  }

  Widget _orderCard(OrderModel order) {
    return Container(
      margin:
      const EdgeInsets.only(bottom: AppSizes.paddingM),
      padding:
      const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
        BorderRadius.circular(AppSizes.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200,
            blurRadius: 6,
          )
        ],
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: Text(
          "Commande ${order.id}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.gray700,
          ),
        ),
        subtitle: Text(
          "${order.total} FCFA",
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [

          /// 📅 Date
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Date: ${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}",
              style: const TextStyle(
                color: AppColors.gray500,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.paddingS),

          /// 📦 Items
          ...order.items.map((item) => Padding(
            padding: const EdgeInsets.only(
                bottom: AppSizes.paddingS),
            child: Row(
              children: [
                Image.network(
                  item.book.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                    width: AppSizes.paddingM),
                Expanded(
                  child: Text(
                    item.book.title,
                    style: const TextStyle(
                      color: AppColors.gray700,
                    ),
                  ),
                ),
                Text(
                  "x${item.quantity}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )),

          const SizedBox(height: AppSizes.paddingM),

          /// 🔄 Status Dropdown
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Statut :",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              DropdownButton<String>(
                value: order.status,
                items: const [
                  DropdownMenuItem(
                    value: "confirmee",
                    child: Text("Confirmée"),
                  ),
                  DropdownMenuItem(
                    value: "en_preparation",
                    child: Text("En préparation"),
                  ),
                  DropdownMenuItem(
                    value: "en_livraison",
                    child: Text("En livraison"),
                  ),
                  DropdownMenuItem(
                    value: "livree",
                    child: Text("Livrée"),
                  ),
                ],
                onChanged: (value) async {
                  await ApiService.updateOrderStatus(
                      order.id, value!);
                  _refresh();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
