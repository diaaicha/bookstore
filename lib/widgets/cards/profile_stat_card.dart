import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class ProfileStatCard extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStatCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.gray500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
