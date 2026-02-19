import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home/home_screen.dart';
import 'admin/admin_dashboard_screen.dart';
import 'auth/auth_screen.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.isLoggedIn) {
      return AuthScreen();
    }

    if (auth.role == 'admin') {
      return const AdminDashboardScreen();
    }

    return const HomeScreen();
  }
}
