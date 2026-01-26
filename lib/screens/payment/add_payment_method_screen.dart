import 'package:flutter/material.dart';
import '../../widgets/inputs/text_input.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../core/constants/colors.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  AddPaymentMethodScreen({super.key});

  final cardCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final dateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Ajouter un paiement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextInput(hint: 'Numéro de carte', controller: cardCtrl),
            const SizedBox(height: 12),
            TextInput(hint: 'Nom sur la carte', controller: nameCtrl),
            const SizedBox(height: 12),
            TextInput(hint: 'Expiration', controller: dateCtrl),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Enregistrer',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
