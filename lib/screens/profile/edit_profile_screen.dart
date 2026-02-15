import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';
import '../../widgets/inputs/text_input.dart';
import '../../widgets/buttons/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;

  @override
  void initState() {
    super.initState();

    final user =
        Provider.of<AuthProvider>(context, listen: false).user;

    nameCtrl = TextEditingController(text: user?.name ?? '');
    emailCtrl = TextEditingController(text: user?.email ?? '');
    phoneCtrl = TextEditingController(text: user?.phone ?? '');
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ================= FOOTER =================
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (index == 1) Navigator.pushNamed(context, AppRoutes.books);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.cart);
          if (index == 3) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= NOM =================
                const Text(
                  'Nom complet',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                IconTheme(
                  data: IconThemeData(
                    color: Colors.grey.shade400, // 👈 GRIS CLAIR
                  ),
                  child: TextInput(
                    hint: 'Nom complet',
                    controller: nameCtrl,
                    prefixIcon: Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 16),

                // ================= EMAIL =================
                const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                IconTheme(
                  data: IconThemeData(
                    color: Colors.grey.shade400,
                  ),
                  child: TextInput(
                    hint: 'Email',
                    controller: emailCtrl,
                    prefixIcon: Icons.email_outlined,
                  ),
                ),

                const SizedBox(height: 16),

                // ================= TÉLÉPHONE =================
                const Text(
                  'Téléphone',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                IconTheme(
                  data: IconThemeData(
                    color: Colors.grey.shade400,
                  ),
                  child: TextInput(
                    hint: 'Téléphone',
                    controller: phoneCtrl,
                    prefixIcon: Icons.phone_outlined,
                  ),
                ),

                const SizedBox(height: 28),

                // ================= BOUTON =================
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: PrimaryButton(
                    text: 'Enregistrer les modifications',
                    onPressed: () {
                      authProvider.updateProfile(
                        name: nameCtrl.text,
                        email: emailCtrl.text,
                        phone: phoneCtrl.text,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
