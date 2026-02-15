import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppDarkTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.darkBg,
      primaryColor: AppColors.primary,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.darkBg,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkCard,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      cardColor: AppColors.darkCard,

      dividerColor: Colors.white12,

      iconTheme: const IconThemeData(
        color: Colors.white70,
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.primary,
        textColor: Colors.white,
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
      ),
    );
  }
}
