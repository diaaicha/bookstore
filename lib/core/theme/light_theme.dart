import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppLightTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.background,
      ),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.gray700),
      ),
    );
  }
}
