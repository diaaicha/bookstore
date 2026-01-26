import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('À propos')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'BookStore App\nVersion 1.0.0\n\nApplication de vente de livres.',
        ),
      ),
    );
  }
}
