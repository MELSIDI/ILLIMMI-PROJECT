import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Les thèmes visuels supportés pour le tableau interactif d'ILLIMMI.
enum BoardThemeType {
  green,      // Tableau Vert Ardoise d'école (par défaut)
  dark,       // Tableau Noir Ardoise minéral
  blue,       // Tableau Bleu Marine / Blueprint
  whiteboard, // Tableau Blanc Velleda
}

/// Configuration complète d'un thème de tableau.
/// Partagée entre le lecteur interactif (`CoursePlayer`) et le harnais de
/// capture de feedback visuel (`buildCaptureWidget`), garantissant que le
/// feedback envoyé à l'IA multimodale est TOUJOURS fidèle au thème choisi.
class BoardTheme {
  final BoardThemeType type;
  final String label;
  final Color backgroundColor;
  final List<Color> gradientColors;
  final Color defaultDrawColor;
  final Color smudgeColor;
  final bool hasTexture;
  final Color borderColor;

  const BoardTheme({
    required this.type,
    required this.label,
    required this.backgroundColor,
    required this.gradientColors,
    required this.defaultDrawColor,
    required this.smudgeColor,
    this.hasTexture = true,
    this.borderColor = const Color(0x22FFFFFF),
  });

  /// 1. Vert Ardoise classique (style école traditionnel)
  static const BoardTheme green = BoardTheme(
    type: BoardThemeType.green,
    label: 'Vert Ardoise',
    backgroundColor: AppTheme.chalkboardGreenDeep,
    gradientColors: [
      AppTheme.chalkboardGreenLight,
      AppTheme.chalkboardGreenMedium,
      AppTheme.chalkboardGreenDeep,
    ],
    defaultDrawColor: Color(0xFFF2F6F3),
    smudgeColor: Colors.white,
    hasTexture: true,
    borderColor: Color(0x22FFFFFF),
  );

  /// 2. Noir Ardoise minéral (noir profond avec poussière de craie)
  static const BoardTheme dark = BoardTheme(
    type: BoardThemeType.dark,
    label: 'Noir Ardoise',
    backgroundColor: Color(0xFF111413),
    gradientColors: [
      Color(0xFF222725),
      Color(0xFF171A19),
      Color(0xFF111413),
    ],
    defaultDrawColor: Color(0xFFF5F7F6),
    smudgeColor: Colors.white,
    hasTexture: true,
    borderColor: Color(0x22FFFFFF),
  );

  /// 3. Bleu Ardoise (style blueprint / tableau de conférence navy)
  static const BoardTheme blue = BoardTheme(
    type: BoardThemeType.blue,
    label: 'Bleu Ardoise',
    backgroundColor: Color(0xFF0C1824),
    gradientColors: [
      Color(0xFF182E44),
      Color(0xFF112233),
      Color(0xFF0C1824),
    ],
    defaultDrawColor: Color(0xFFEDF5FC),
    smudgeColor: Color(0xFF6CB8F6),
    hasTexture: true,
    borderColor: Color(0x266CB8F6),
  );

  /// 4. Tableau Blanc (style Velleda, fond blanc/ivoire et encre sombre)
  static const BoardTheme whiteboard = BoardTheme(
    type: BoardThemeType.whiteboard,
    label: 'Tableau Blanc',
    backgroundColor: Color(0xFFF8F9FA),
    gradientColors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8F9FA),
      Color(0xFFEEF1F4),
    ],
    defaultDrawColor: Color(0xFF1E293B),
    smudgeColor: Colors.black,
    hasTexture: false,
    borderColor: Color(0x22000000),
  );

  static const List<BoardTheme> all = [green, dark, blue, whiteboard];

  static BoardTheme fromType(BoardThemeType type) {
    switch (type) {
      case BoardThemeType.green:
        return green;
      case BoardThemeType.dark:
        return dark;
      case BoardThemeType.blue:
        return blue;
      case BoardThemeType.whiteboard:
        return whiteboard;
    }
  }

  static BoardTheme fromString(String? name) {
    if (name == null) return green;
    final lower = name.toLowerCase().trim();
    if (lower == 'dark' || lower == 'noir' || lower == 'black') return dark;
    if (lower == 'blue' || lower == 'bleu' || lower == 'navy') return blue;
    if (lower == 'white' || lower == 'whiteboard' || lower == 'blanc') return whiteboard;
    return green;
  }
}
