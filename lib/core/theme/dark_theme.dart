import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppDarkTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      primaryColor: AppColors.primary,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkCard,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.darkBg,
      ),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.white),
      ),
    );
  }
}
