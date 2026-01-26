import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/inputs/text_input.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../core/constants/colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user!;

    nameCtrl.text = user.name;
    emailCtrl.text = user.email;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Modifier le profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextInput(hint: 'Nom', controller: nameCtrl),
            const SizedBox(height: 12),
            TextInput(hint: 'Email', controller: emailCtrl),
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
