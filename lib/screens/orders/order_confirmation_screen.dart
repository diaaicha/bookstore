import 'package:flutter/material.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../core/constants/colors.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle,
                  color: AppColors.green, size: 80),
              const SizedBox(height: 24),
              const Text(
                'Commande confirmée',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Voir mes commandes',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/orders'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
