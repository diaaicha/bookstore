import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Aide & Support')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Pour toute assistance, contactez le support à support@bookstore.com',
        ),
      ),
    );
  }
}
