import 'package:flutter/material.dart';

class AppColors {
  // Base
  static const Color black = Color(0xFF0B0E14);
  static const Color white = Color(0xFFFFFFFF);

  // Backgrounds (Dark)
  static const Color background = Color(0xFF0E1117); // Deep premium dark
  static const Color card = Color(0xFF161B22); // Elevated dark card
  static const Color divider = Color(0xFF242A38);

  // Brand
  static const Color primary = Color(0xFF7C5CFF); // Royal Purple
  static const Color secondary = Color(0xFF4C7DFF); // Cool Blue
  static const Color accent = Color(0xFFFFC857); // Soft Gold

  // Status
  static const Color danger = Color(0xFFFF4C4C);
  static const Color success = Color(0xFF22C55E);

  // Text (Dark)
  static const Color textPrimary = Color(0xFFF2F4F8); // Soft white
  static const Color textSecondary = Color(0xFF9AA4B2); // Muted gray
}

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.card,
      error: AppColors.danger,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.textPrimary,
      onError: AppColors.white,
    ),

    /// -------------------- TEXT --------------------
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),

    /// -------------------- APP BAR --------------------
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.card,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),

    /// -------------------- BUTTONS --------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    /// -------------------- FAB --------------------
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.black,
    ),

    dividerColor: AppColors.divider,

    /// -------------------- CARDS --------------------
    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
