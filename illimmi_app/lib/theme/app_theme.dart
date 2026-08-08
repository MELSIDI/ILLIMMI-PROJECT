import 'package:flutter/material.dart';

/// Design system : Material 3, palette générée depuis une seule couleur
/// germe (light + dark), et quelques constantes d'espacement/largeur
/// réutilisées par la sidebar façon Claude/ChatGPT.
class AppTheme {
  static const seedColor = Color(0xFF6750A4);

  static ThemeData light() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  );

  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
  );
}

class Spacing {
  static const double sidebarWidth = 280;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}
