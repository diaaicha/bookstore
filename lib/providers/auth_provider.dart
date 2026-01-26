import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool isLoggedIn = false;

  UserModel? get user => _user;

  // ✅ GETTERS UTILISABLES PARTOUT DANS L’APP
  String get userName => _user?.name ?? 'Utilisateur';
  String get email => _user?.email ?? '';
  String get phone => _user?.phone ?? '';

  void login({
    required String email,
    String? name,
    String? phone,
  }) {
    _user = UserModel(
      name: name ?? 'Utilisateur',
      email: email,
      phone: phone ?? '',
    );
    isLoggedIn = true;
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    if (_user == null) return;

    _user = _user!.copyWith(
      name: name,
      email: email,
      phone: phone,
    );
    notifyListeners();
  }

  void logout() {
    _user = null;
    isLoggedIn = false;
    notifyListeners();
  }
}
