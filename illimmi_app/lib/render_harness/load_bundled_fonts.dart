import 'dart:convert';

import 'package:flutter/services.dart';

/// Charge toutes les polices déclarées dans `FontManifest.json` — celles de
/// l'app et celles embarquées par les packages (notamment les glyphes
/// mathématiques KaTeX de `flutter_math_fork` et l'icône `MaterialIcons`
/// utilisée pour le curseur souris). Sans cet appel, `flutter test` affiche
/// tout texte avec la police de test "Ahem" (un carré par caractère), ce qui
/// empêcherait une reproduction fidèle du tableau — voir "Décisions" dans
/// world-model-visual-feedback.md.
///
/// Limite connue : la famille `Roboto` utilisée par défaut pour le texte
/// simple (`AdvancedTextWidget`) n'est déclarée nulle part dans le bundle de
/// cette app (elle vient normalement de la police système), donc elle reste
/// rendue en "Ahem" — seul le LaTeX (KaTeX) et les icônes sont concernés par
/// ce correctif. Corriger le texte simple demanderait de fournir un fichier
/// Roboto.ttf réel comme asset de test, hors scope de cette itération.
Future<void> loadBundledFonts() async {
  final manifestJson = await rootBundle.loadString('FontManifest.json');
  final manifest = jsonDecode(manifestJson) as List<dynamic>;

  for (final entry in manifest) {
    final map = entry as Map<String, dynamic>;
    final family = map['family'] as String;
    final fonts = map['fonts'] as List<dynamic>;

    final loader = FontLoader(family);
    for (final font in fonts) {
      final asset = (font as Map<String, dynamic>)['asset'] as String;
      loader.addFont(rootBundle.load(asset));
    }
    await loader.load();
  }
}
