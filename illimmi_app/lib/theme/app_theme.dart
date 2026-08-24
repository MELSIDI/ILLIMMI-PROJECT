import 'package:flutter/material.dart';

/// Design system : Tableau Vert (Chalkboard) ILLIMMI
/// Palette de couleurs authentique de tableau d'école en ardoise verte,
/// cadre en bois, craies colorées pastel, effaceur en feutre et bordures crayonnées.
class AppTheme {
  // Verts Ardoise / Chalkboard Base
  static const chalkboardGreenDeep = Color(0xFF142B20);
  static const chalkboardGreenMedium = Color(0xFF1A3629);
  static const chalkboardGreenLight = Color(0xFF224535);
  static const chalkboardSurface = Color(0xFF1B382B);
  static const chalkboardSurfaceContainer = Color(0xFF204233);
  static const chalkboardSurfaceGlass = Color(0x380F2519);
  static const chalkboardCardGlass = Color(0x280D2116);

  // Craies & Poussière (Chalk & Dust)
  static const chalkWhite = Color(0xFFF2F6F3);
  static const chalkWhiteBright = Color(0xFFFFFFFF);
  static const chalkDust = Color(0xFFB0C5B8);
  static const chalkDustMuted = Color(0xFF7E978A);
  static const chalkBorder = Color(0x4DFFFFFF);
  static const chalkBorderFaint = Color(0x26FFFFFF);
  static const chalkBorderBold = Color(0x80FFFFFF);

  // Pastels Craie (Chalk Accents)
  static const chalkBlue = Color(0xFF6CB8F6);
  static const chalkPurple = Color(0xFFC084FC);
  static const chalkPink = Color(0xFFFA89A4);
  static const chalkGreen = Color(0xFF4ADE80);
  static const chalkYellow = Color(0xFFFDE047);
  static const chalkOrange = Color(0xFFFB923C);
  static const chalkCyan = Color(0xFF38BDF8);

  // Bois & Accessoires (Wood Frame & Eraser)
  static const woodDark = Color(0xFF2D180C);
  static const woodMedium = Color(0xFF4D2A16);
  static const woodLight = Color(0xFF6E3E22);
  static const woodHighlight = Color(0xFF8A512E);
  static const feltGrey = Color(0xFF5A5A5A);
  static const feltDark = Color(0xFF3E3E3E);

  // Dégradés Craie Pastel
  static const LinearGradient chalkGradient = LinearGradient(
    colors: [
      Color(0xFF6CB8F6),
      Color(0xFFC084FC),
      Color(0xFFFA89A4),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient chalkSparkleGradient = LinearGradient(
    colors: [
      Color(0xFF38BDF8),
      Color(0xFF6CB8F6),
      Color(0xFFC084FC),
      Color(0xFFFA89A4),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Alias pour rétrocompatibilité Gemini
  static const darkBackground = chalkboardGreenDeep;
  static const darkSurface = chalkboardSurface;
  static const darkSurfaceContainer = chalkboardSurfaceContainer;
  static const darkBorder = chalkBorder;
  static const darkTextPrimary = chalkWhite;
  static const darkTextSecondary = chalkDust;

  static const lightBackground = chalkboardGreenDeep;
  static const lightSurface = chalkboardSurface;
  static const lightSurfaceContainer = chalkboardSurfaceContainer;
  static const lightBorder = chalkBorder;
  static const lightTextPrimary = chalkWhite;
  static const lightTextSecondary = chalkDust;

  static const geminiBlue = chalkBlue;
  static const geminiPurple = chalkPurple;
  static const geminiPink = chalkPink;
  static const geminiCyan = chalkCyan;
  static const geminiGradient = chalkGradient;
  static const geminiSparkleGradient = chalkSparkleGradient;

  static ThemeData chalkboardTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: chalkboardGreenDeep,
        canvasColor: chalkboardGreenDeep,
        cardColor: chalkboardSurface,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: chalkBlue,
          onPrimary: chalkboardGreenDeep,
          secondary: chalkPurple,
          onSecondary: chalkWhite,
          error: chalkPink,
          onError: chalkboardGreenDeep,
          surface: chalkboardSurface,
          onSurface: chalkWhite,
          surfaceContainer: chalkboardSurfaceContainer,
          surfaceContainerLow: chalkboardSurfaceGlass,
          outline: chalkBorder,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: chalkWhite, letterSpacing: -0.5),
          displayMedium: TextStyle(color: chalkWhite, letterSpacing: -0.5),
          displaySmall: TextStyle(color: chalkWhite),
          headlineLarge: TextStyle(color: chalkWhite, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: chalkWhite, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(color: chalkWhite, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: chalkWhite, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: chalkWhite, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(color: chalkDust, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: chalkWhite),
          bodyMedium: TextStyle(color: chalkWhite),
          bodySmall: TextStyle(color: chalkDust),
          labelLarge: TextStyle(color: chalkDust, fontWeight: FontWeight.w600),
          labelMedium: TextStyle(color: chalkDust),
          labelSmall: TextStyle(color: chalkDustMuted),
        ),
        cardTheme: CardThemeData(
          color: chalkboardCardGlass,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: chalkBorder, width: 1.2),
          ),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: chalkboardSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: chalkBorder, width: 1.2),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: chalkboardSurfaceGlass,
          hintStyle: const TextStyle(color: chalkDustMuted),
          labelStyle: const TextStyle(color: chalkDust),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: chalkBorder, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: chalkBorder, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: chalkBlue, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: chalkWhite,
          inactiveTrackColor: chalkBorderFaint,
          thumbColor: chalkWhite,
          overlayColor: Color(0x336CB8F6),
          trackHeight: 3,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
        ),
        iconTheme: const IconThemeData(
          color: chalkWhite,
        ),
      );

  static ThemeData dark() => chalkboardTheme();
  static ThemeData light() => chalkboardTheme();
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


