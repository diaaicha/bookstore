import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {

  UserModel? _user;
  String? _role;
  bool isLoggedIn = false;

  UserModel? get user => _user;
  String get role => _role ?? 'user';

  String get userName => _user?.name ?? 'Utilisateur';
  String get email => _user?.email ?? '';
  String get phone => _user?.phone ?? '';

  // ================= LOGIN =================
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {

      // 1️⃣ Connexion Firebase
      final credential =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw Exception("Connexion échouée.");
      }

      final uid = firebaseUser.uid;

      // 2️⃣ Récupérer Firestore
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (!doc.exists) {
        throw Exception(
            "Utilisateur introuvable dans Firestore.");
      }

      final data = doc.data();

      if (data == null) {
        throw Exception(
            "Données utilisateur invalides.");
      }

      // 3️⃣ Créer UserModel local
      _user = UserModel(
        uid: uid,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        role: data['role'] ?? 'user',
        createdAt: null,
      );

      // 🔥 IMPORTANT : stocker le rôle
      _role = data['role'] ?? 'user';

      isLoggedIn = true;
      notifyListeners();

    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        throw Exception(
            "Aucun utilisateur trouvé avec cet email.");
      } else if (e.code == 'wrong-password') {
        throw Exception(
            "Mot de passe incorrect.");
      } else if (e.code == 'invalid-email') {
        throw Exception("Email invalide.");
      } else {
        throw Exception(
            "Erreur de connexion : ${e.message}");
      }

    } catch (e) {
      throw Exception(
          "Erreur : ${e.toString()}");
    }
  }

  // ================= REGISTER =================
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {

    final credential =
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final uid = credential.user!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': 'user',
      'createdAt':
      FieldValue.serverTimestamp(),
    });

    _user = UserModel(
      uid: uid,
      name: name,
      email: email,
      phone: phone,
      role: 'user',
      createdAt: null,
    );

    _role = 'user';

    isLoggedIn = true;
    notifyListeners();
  }

  // ================= UPDATE PROFILE =================
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {

    if (_user == null) return;

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
      'name': name,
      'email': email,
      'phone': phone,
    });

    _user = _user!.copyWith(
      name: name,
      email: email,
      phone: phone,
    );

    notifyListeners();
  }

  // ================= LOGOUT =================
  Future<void> logout() async {

    await FirebaseAuth.instance.signOut();

    _user = null;
    _role = null;
    isLoggedIn = false;

    notifyListeners();
  }
}
