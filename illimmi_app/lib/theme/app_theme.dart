import 'package:flutter/material.dart';

/// Design system : Gemini Web Style
/// Palette de couleurs fidèle à Google Gemini (dark #131314 / light #F0F4F9),
/// dégradés emblématiques et tokens d'espacement.
class AppTheme {
  // Gemini Dark Colors
  static const darkBackground = Color(0xFF131314);
  static const darkSurface = Color(0xFF1E1F20);
  static const darkSurfaceContainer = Color(0xFF282A2C);
  static const darkBorder = Color(0xFF37393B);
  static const darkTextPrimary = Color(0xFFE3E2E6);
  static const darkTextSecondary = Color(0xFFC4C7C5);

  // Gemini Light Colors
  static const lightBackground = Color(0xFFF0F4F9);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceContainer = Color(0xFFE9EEF6);
  static const lightBorder = Color(0xFFE1E3E1);
  static const lightTextPrimary = Color(0xFF1F1F1F);
  static const lightTextSecondary = Color(0xFF444746);

  // Gemini Accents & Gradients
  static const geminiBlue = Color(0xFF4285F4);
  static const geminiPurple = Color(0xFF9B51E0);
  static const geminiPink = Color(0xFFD9657B);
  static const geminiCyan = Color(0xFF1BA1E2);

  static const LinearGradient geminiGradient = LinearGradient(
    colors: [
      Color(0xFF4285F4),
      Color(0xFF9B51E0),
      Color(0xFFD9657B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient geminiSparkleGradient = LinearGradient(
    colors: [
      Color(0xFF1BA1E2),
      Color(0xFF4285F4),
      Color(0xFF9B51E0),
      Color(0xFFE91E63),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: geminiBlue,
          brightness: Brightness.light,
          surface: lightSurface,
          surfaceContainer: lightSurfaceContainer,
          surfaceContainerLow: lightSurfaceContainer,
          primary: geminiBlue,
          onSurface: lightTextPrimary,
        ),
        cardTheme: CardThemeData(
          color: lightSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: lightBorder, width: 1),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightSurfaceContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: geminiBlue, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      );

  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: geminiBlue,
          brightness: Brightness.dark,
          surface: darkSurface,
          surfaceContainer: darkSurface,
          surfaceContainerLow: darkSurfaceContainer,
          primary: const Color(0xFFA8C7FA),
          onSurface: darkTextPrimary,
        ),
        cardTheme: CardThemeData(
          color: darkSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: darkBorder, width: 1),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkSurfaceContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Color(0xFFA8C7FA), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      );
}

class Spacing {
  static const double sidebarWidth = 280;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

