import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Moyens de paiement')),
      body: ListTile(
        title: const Text('Ajouter un moyen de paiement'),
        trailing: const Icon(Icons.add),
        onTap: () => Navigator.pushNamed(context, '/add-payment'),
      ),
    );
  }
}
