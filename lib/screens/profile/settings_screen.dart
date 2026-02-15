import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ================= BOTTOM NAV =================
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            children: [
              _tile(
                icon: Icons.person_outline,
                title: 'Modifier le profil',
                subtitle: 'Nom, email, téléphone',
                onTap: () {
                  
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                },
              ),
              _divider(),
              _switchTile(
                icon: Icons.dark_mode_outlined,
                title: 'Mode sombre',
                subtitle: 'Activer le thème sombre',
                value: themeProvider.isDark,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
              _divider(),
              _tile(
                icon: Icons.language_outlined,
                title: 'Langue',
                subtitle: 'Français',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.language);
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          _card(
            children: [
              _tile(
                icon: Icons.lock_outline,
                title: 'Sécurité',
                subtitle: 'Mot de passe, authentification',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.security);
                },
              ),
              _divider(),
              _switchTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications push',
                subtitle: 'Recevoir les notifications',
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          _card(
            children: [
              _tile(
                icon: Icons.download_outlined,
                title: 'Télécharger mes données',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Téléchargement en cours...'),
                    ),
                  );
                },
              ),
              _divider(),
              _tile(
                icon: Icons.delete_outline,
                title: 'Supprimer mon compte',
                titleColor: Colors.red,
                iconColor: Colors.red,
                onTap: _confirmDeleteAccount,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= UI COMPONENTS =================

  Widget _card({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor:
        (iconColor ?? AppColors.primary).withOpacity(0.12),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      )
          : null,
      trailing: const Icon(
        Icons.chevron_right,
        size: 20,
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.primary.withOpacity(0.12),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Transform.scale(
        scale: 0.85, // 👈 rend le switch plus fin
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,                 // rond blanc
          activeTrackColor: AppColors.primary,       // fond orange ON
          inactiveThumbColor: Colors.white,          // rond blanc OFF
          inactiveTrackColor: Colors.grey.shade800,  // fond sombre OFF
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),

    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 0.6,
      color: Colors.grey.shade300,
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Supprimer le compte'),
        content: const Text(
          'Cette action est définitive. Voulez-vous continuer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: logique suppression compte
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
