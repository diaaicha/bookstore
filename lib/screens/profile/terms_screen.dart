import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Conditions d'utilisation"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              icon: Icons.info_outline,
              iconColor: AppColors.primary,
              title: "Introduction",
              content:
              "Bienvenue sur BookStore. Ces conditions régissent votre utilisation de notre application.",
            ),
            _card(
              icon: Icons.rule,
              iconColor: Colors.orange,
              title: "Utilisation de l'application",
              content:
              "Vous acceptez de respecter toutes les lois applicables et de ne pas utiliser l'application à des fins illégales.",
            ),
            _card(
              icon: Icons.lock_outline,
              iconColor: Colors.red,
              title: "Responsabilité",
              content:
              "BookStore ne peut être tenu responsable des dommages indirects liés à l'utilisation de l'application.",
            ),
          ],
        ),
      ),
    );
  }

  static Widget _card({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
