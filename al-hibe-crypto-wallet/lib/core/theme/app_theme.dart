import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color backgroundBlack = Color(0xFF0D0D0D);
  static const Color cardBlack = Color(0xFF1A1A1A);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGray = Color(0xFF8E8E93);
  static const Color successGreen = Color(0xFF00C851);
  static const Color errorRed = Color(0xFFFF4444);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: MaterialColor(0xFFFFD700, {
        50: Color(0xFFFFFDF0),
        100: Color(0xFFFFFAE0),
        200: Color(0xFFFFF5C2),
        300: Color(0xFFFFF0A3),
        400: Color(0xFFFFEB85),
        500: primaryGold,
        600: Color(0xFFE6C200),
        700: Color(0xFFCCAD00),
        800: Color(0xFFB39900),
        900: Color(0xFF998500),
      }),
      scaffoldBackgroundColor: backgroundBlack,
      cardColor: cardBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundBlack,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryGold),
        titleTextStyle: TextStyle(
          color: textWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: backgroundBlack,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGold,
          side: const BorderSide(color: primaryGold, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBlack,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        labelStyle: const TextStyle(color: textGray),
        hintStyle: const TextStyle(color: textGray),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textWhite,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textWhite,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: textWhite,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          color: textWhite,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: textWhite,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: textWhite,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: textWhite,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: textWhite,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: textWhite,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: textGray,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      iconTheme: const IconThemeData(
        color: primaryGold,
        size: 24,
      ),
      dividerColor: textGray.withOpacity(0.2),
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        secondary: darkGold,
        surface: cardBlack,
        background: backgroundBlack,
        error: errorRed,
        onPrimary: backgroundBlack,
        onSecondary: textWhite,
        onSurface: textWhite,
        onBackground: textWhite,
        onError: textWhite,
      ),
    );
  }
}
