import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';

// PROVIDERS
import 'providers/auth_provider.dart';
import 'providers/book_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/order_provider.dart';
import 'providers/theme_provider.dart';

// SCREENS AVEC ARGUMENTS
import 'screens/orders/order_detail_screen.dart';
import 'models/order_model.dart';

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, theme, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BookStore',

            // ================= THEME =================
            theme: AppLightTheme.theme,
            darkTheme: AppDarkTheme.theme,
            themeMode: theme.themeMode,

            // ================= ROUTING =================
            initialRoute: AppRoutes.auth,
            routes: AppRoutes.routes,

            // 🔑 ROUTES AVEC ARGUMENTS (OBLIGATOIRE)
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case AppRoutes.orderDetail:
                  final order = settings.arguments as OrderModel;
                  return MaterialPageRoute(
                    builder: (_) => OrderDetailScreen(order: order),
                  );

                default:
                  return null;
              }
            },
          );
        },
      ),
    );
  }
}
