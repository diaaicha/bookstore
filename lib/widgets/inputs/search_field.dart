import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;

  const SearchField({
    super.key,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.gray400),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              readOnly: readOnly,
              onTap: onTap,
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Rechercher un livre...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
