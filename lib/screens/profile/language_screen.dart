import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../providers/language_provider.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Langue'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 3,
        onTap: (_) {},
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(context, provider),

            const SizedBox(height: 24),

            // 🔥 BOUTON VALIDER
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () async {
                  await provider.confirmLanguage();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Valider',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context, LanguageProvider provider) {
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
      child: Column(
        children: [
          _langTile(provider, 'Français', '🇫🇷', 'fr'),
          _divider(),
          _langTile(provider, 'English', '🇬🇧', 'en'),
          _divider(),
          _langTile(provider, 'العربية', '🇸🇦', 'ar'),
          _divider(),
          _langTile(provider, 'Español', '🇪🇸', 'es'),
          _divider(),
          _langTile(provider, 'Português', '🇵🇹', 'pt'),
          _divider(),
          _langTile(provider, 'Deutsch', '🇩🇪', 'de'),
        ],
      ),
    );
  }

  Widget _langTile(
      LanguageProvider provider,
      String label,
      String flag,
      String code,
      ) {
    final selected = provider.isSelected(code);

    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 22)),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: selected
          ? const Icon(Icons.check, color: AppColors.primary)
          : null,
      onTap: () {
        provider.selectTemp(code);
      },
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 0.6,
      color: Colors.grey.shade300,
    );
  }
}
