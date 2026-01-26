import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        '🔥 -25% sur les best-sellers cette semaine !',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
