import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // pour Clipboard
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/colors.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  final String phoneNumber = '+225 XX XX XX XX XX';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Appeler le support'),
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
            // Carte principale
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icône téléphone
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.phone_outlined, color: AppColors.primary, size: 32),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Appelez notre support',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phoneNumber,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // Bouton Appeler maintenant
                  ElevatedButton.icon(
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text(
                      'Appeler maintenant',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () async {
                      final Uri url = Uri(scheme: 'tel', path: phoneNumber);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  // Bouton Copier le numéro avec orange style Historique
                  ElevatedButton.icon(
                    icon: const Icon(Icons.copy, color: Colors.white),
                    label: const Text(
                      'Copier le numéro',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, // Orange Historique
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: phoneNumber));
                      // Message temporaire en bas
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: const [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 8),
                              Expanded(child: Text('Numéro copié !')),
                            ],
                          ),
                          backgroundColor: Colors.green[700],
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Message d'info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Notre équipe est disponible 24/7 pour répondre à vos appels rapidement.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
