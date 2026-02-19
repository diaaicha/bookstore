import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= REGISTER =================
  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {

    // 1️⃣ Créer compte Firebase
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    // 2️⃣ Créer document Firestore
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return credential;
  }

  // ================= LOGIN =================
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {

    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential;
  }

  // ================= GET USER DATA =================
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ================= CURRENT USER =================
  User? get currentUser => _auth.currentUser;

  // ================= AUTH STATE STREAM =================
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
