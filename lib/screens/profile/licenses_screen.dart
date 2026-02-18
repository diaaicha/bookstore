import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Licences"),
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
              icon: Icons.code_outlined,
              iconColor: AppColors.primary,
              title: "Flutter",
              content:
              "BookStore utilise Flutter, framework open source pour créer des applications multiplateformes.",
            ),
            _card(
              icon: Icons.copyright_outlined,
              iconColor: Colors.orange,
              title: "Dépendances",
              content:
              "Toutes les bibliothèques tierces utilisées respectent leurs licences respectives (MIT, BSD, Apache, etc.).",
            ),
            _card(
              icon: Icons.book_outlined,
              iconColor: Colors.red,
              title: "Contenu",
              content:
              "Les images et textes inclus dans l'application sont soumis à des droits d'auteur et ne peuvent pas être reproduits sans autorisation.",
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
