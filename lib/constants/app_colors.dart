import 'package:flutter/material.dart';

class AppColors {
  // --- BASE ---
  static const Color black = Color(0xFF0B0C10);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;

  // --- DARK THEME (Premium Obsidian) ---
  static const Color darkBackground = Color(0xFF0F1115);
  static const Color darkSurface = Color(0xFF1A1D23);
  static const Color darkCard = Color(0xFF22262F);
  static const Color darkBorder = Color(0xFF2D333D);

  // --- LIGHT THEME (Soft Arctic) ---
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // --- BRAND (Vibrant 2026) ---
  static const Color primary = Color(0xFF8B5CF6); // Electric Violet
  static const Color secondary = Color(0xFF06B6D4); // Neon Cyan
  static const Color accent = Color(0xFFF59E0B); // Amber Glow

  // --- COMPATIBILITY NAMES (Restored) ---
  static const Color background = darkBackground;
  static const Color card = darkCard;
  static const Color danger = Color(0xFFEF4444);
  static const Color divider = darkBorder;

  // --- GRADIENTS ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // --- TEXT ---
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  static const Color lightTextPrimary = Color(0xFF1E293B);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Compatibility text names
  static const Color textPrimary = darkTextPrimary;
  static const Color textSecondary = darkTextSecondary;

  // --- STATUS ---
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
}

class AppTheme {
  static ThemeData get darkTheme => getTheme(isDark: true);
  static ThemeData get lightTheme => getTheme(isDark: false);

  static ThemeData getTheme({required bool isDark}) {
    final baseColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'Outfit', // Suggested 2026 font
      scaffoldBackgroundColor: baseColor,

      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        surface: surfaceColor,
        onSurface: textPrimary,
        error: AppColors.error,
        onError: AppColors.white,
      ),

      // --- TEXT THEME ---
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textPrimary,
            letterSpacing: -1),
        displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textPrimary,
            letterSpacing: -0.5),
        headlineLarge: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
        bodyLarge: TextStyle(fontSize: 16, color: textPrimary),
        bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
        labelLarge: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: textPrimary),
      ),

      // --- CARD THEME ---
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),

      // --- BUTTON THEMES ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(88, 56),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: baseColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
      ),
    );
  }
}
