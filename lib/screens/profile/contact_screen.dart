import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Contacter le support'),
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
            // Message d'intro
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.headset_mic_outlined, color: AppColors.primary, size: 32),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Notre équipe est disponible 24/7 pour vous aider',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Bouton principal Contacter le support
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Support contacté !")),
                      );
                    },
                    icon: const Icon(Icons.headset_mic_outlined, color: Colors.white),
                    label: const Text(
                      "Contacter le support",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Réseaux sociaux
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      SocialCard(icon: Icons.facebook, label: "Facebook", color: Color(0xFF4267B2)),
                      SocialCard(icon: Icons.camera_alt_outlined, label: "Instagram", color: Color(0xFFC13584)),
                      SocialCard(icon: Icons.video_collection, label: "TikTok", color: Color(0xFF69C9D0)),
                      SocialCard(icon: Icons.snapchat, label: "Snapchat", color: Color(0xFFFFFC00)),
                    ],
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

// =================== SOCIAL CARD ===================
class SocialCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const SocialCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label cliqué !')),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
