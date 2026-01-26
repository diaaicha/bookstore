import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/text_input.dart';
import '../../widgets/navbar/bottom_navbar.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool rememberMe = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void _login() {
    context.read<AuthProvider>().login(
      email: emailCtrl.text,
    );

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // ✅ FOOTER AJOUTÉ
      bottomNavigationBar: BottomNavbar(
        currentIndex: 3, // Profil (écran auth)
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.home,
              );
              break;

            case 1:
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.books,
              );
              break;

            case 2:
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.cart,
              );
              break;

            case 3:
            // Déjà sur Auth (profil non connecté)
              break;
          }
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // LOGO
              Container(
                height: 72,
                width: 72,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Colors.white,
                  size: 36,
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'BookStore',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bienvenue ! Connectez-vous pour continuer',
                style: TextStyle(color: AppColors.gray500),
              ),

              const SizedBox(height: 24),

              // TABS
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.gray400,
                tabs: const [
                  Tab(text: 'Connexion'),
                  Tab(text: 'Inscription'),
                ],
              ),

              const SizedBox(height: 24),

              // FORM
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email'),
                  const SizedBox(height: 6),
                  TextInput(
                    controller: emailCtrl,
                    hint: 'exemple@email.com',
                    prefixIcon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 16),

                  const Text('Mot de passe'),
                  const SizedBox(height: 6),
                  TextInput(
                    controller: passwordCtrl,
                    hint: '••••••••',
                    obscureText: hidePassword,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        activeColor: AppColors.primary,
                        onChanged: (v) {
                          setState(() => rememberMe = v ?? false);
                        },
                      ),
                      const Text('Se souvenir de moi'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  PrimaryButton(
                    text: 'Se connecter',
                    onPressed: _login,
                  ),

                  const SizedBox(height: 24),
                  const Center(child: Text('Ou continuer avec')),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      _socialButton('Google', Icons.g_mobiledata),
                      const SizedBox(width: 12),
                      _socialButton('Facebook', Icons.facebook),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(1);
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Vous n'avez pas de compte ? ",
                              style: TextStyle(color: AppColors.gray500),
                            ),
                            TextSpan(
                              text: "Créer un compte",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: AppColors.gray200),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
