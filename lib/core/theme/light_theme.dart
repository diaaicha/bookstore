import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppLightTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.background,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      cardColor: AppColors.white,

      dividerColor: AppColors.gray200,

      iconTheme: const IconThemeData(
        color: AppColors.gray700,
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.primary,
        textColor: AppColors.gray700,
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.gray700),
        bodyMedium: TextStyle(color: AppColors.gray700),
        titleMedium: TextStyle(color: AppColors.gray700),
        labelLarge: TextStyle(color: AppColors.gray700),
      ),
    );
  }
}
