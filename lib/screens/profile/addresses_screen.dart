import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  List<Map<String, String>> addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  // ⚡ Charger les adresses depuis SharedPreferences
  Future<void> _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('addresses') ?? [];
    setState(() {
      addresses = jsonList.map((e) => Map<String, String>.from(json.decode(e))).toList();
    });
  }

  // ⚡ Sauvegarder les adresses
  Future<void> _saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = addresses.map((e) => json.encode(e)).toList();
    await prefs.setStringList('addresses', jsonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adresses')),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final addr = addresses[index];
          return ListTile(
            title: Text(addr['name']!),
            subtitle: Text('${addr['street']}, ${addr['city']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final result = await showDialog<Map<String, String>>(
                      context: context,
                      builder: (context) => EditAddressDialog(address: addr),
                    );
                    if (result != null) {
                      setState(() {
                        addresses[index] = result;
                      });
                      _saveAddresses();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      addresses.removeAt(index);
                    });
                    _saveAddresses();
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context, addr);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newAddress = await showDialog<Map<String, String>>(
            context: context,
            builder: (context) => const EditAddressDialog(),
          );
          if (newAddress != null) {
            setState(() {
              addresses.add(newAddress);
            });
            _saveAddresses();
          }
        },
      ),
    );
  }
}

class EditAddressDialog extends StatefulWidget {
  final Map<String, String>? address;
  const EditAddressDialog({super.key, this.address});

  @override
  State<EditAddressDialog> createState() => _EditAddressDialogState();
}

class _EditAddressDialogState extends State<EditAddressDialog> {
  late TextEditingController nameController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.address?['name']);
    streetController = TextEditingController(text: widget.address?['street']);
    cityController = TextEditingController(text: widget.address?['city']);
    phoneController = TextEditingController(text: widget.address?['phone']);
  }

  @override
  void dispose() {
    nameController.dispose();
    streetController.dispose();
    cityController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.address == null ? 'Ajouter une adresse' : 'Modifier'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nom')),
          TextField(controller: streetController, decoration: const InputDecoration(labelText: 'Rue')),
          TextField(controller: cityController, decoration: const InputDecoration(labelText: 'Ville')),
          TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Téléphone')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'name': nameController.text,
              'street': streetController.text,
              'city': cityController.text,
              'phone': phoneController.text,
            });
          },
          child: const Text('Valider'),
        ),
      ],
    );
  }
}
