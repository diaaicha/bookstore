import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  final List<Map<String, String>> _sentMails = [];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendEmail() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      // Remplacer _showSnack par _showReceptionMessage avec message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tous les champs doivent être remplis !'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final now = DateTime.now();
    _sentMails.add({
      'Prénom': _firstNameController.text,
      'Nom': _lastNameController.text,
      'Email': _emailController.text,
      'Message': _messageController.text,
      'Date': "${now.day}/${now.month}/${now.year}",
      'Heure': "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
    });

    _showReceptionMessage(); // message de succès

    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _messageController.clear();

    FocusScope.of(context).unfocus(); // Pas de focus automatique
  }


  void _showReceptionMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        backgroundColor: Colors.green[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green[800]),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Message bien reçu !',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Icon(Icons.close, color: Colors.green),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showHistory() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Historique des mails',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: _sentMails.isEmpty
                      ? const Center(child: Text('Aucun mail envoyé.'))
                      : ListView.builder(
                    itemCount: _sentMails.length,
                    itemBuilder: (context, index) {
                      final mail = _sentMails[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow('Prénom', mail['Prénom']!),
                            _infoRow('Nom', mail['Nom']!),
                            _infoRow('Email', mail['Email']!),
                            _infoRow('Message', mail['Message']!),
                            _infoRow('Date', mail['Date']!),
                            _infoRow('Heure', mail['Heure']!),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      autofocus: false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Envoyer un email'),
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
            _buildTextField(_firstNameController, 'Prénom', Icons.person),
            const SizedBox(height: 12),
            _buildTextField(_lastNameController, 'Nom', Icons.person_outline),
            const SizedBox(height: 12),
            _buildTextField(_emailController, 'Email', Icons.email),
            const SizedBox(height: 12),
            _buildTextField(_messageController, 'Message', Icons.message, maxLines: 4),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _sendEmail,
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'Envoyer',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showHistory,
                    icon: const Icon(Icons.history),
                    label: const Text('Historique'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
