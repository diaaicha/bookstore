import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Mes adresses')),
      body: const Center(
        child: Text('Aucune adresse enregistrée'),
      ),
    );
  }
}
