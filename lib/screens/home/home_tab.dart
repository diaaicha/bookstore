import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          color: AppColors.primary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenue 👋',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 8),
              Text(
                'Découvrez nos meilleurs livres',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Catégories populaires',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
