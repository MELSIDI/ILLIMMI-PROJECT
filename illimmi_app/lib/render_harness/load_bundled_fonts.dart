import 'dart:convert';

import 'package:flutter/services.dart';

/// Charge toutes les polices déclarées dans `FontManifest.json` — celles de
/// l'app (dont Roboto désormais bundlé dans assets/fonts/) et celles embarquées
/// par les packages (notamment les glyphes mathématiques KaTeX de `flutter_math_fork`
/// et l'icône `MaterialIcons` utilisée pour le curseur souris). Sans cet appel,
/// `flutter test` affiche tout texte avec la police de test "Ahem" (un carré par caractère).
Future<void> loadBundledFonts() async {
  final manifestJson = await rootBundle.loadString('FontManifest.json');
  final manifest = jsonDecode(manifestJson) as List<dynamic>;

  bool loadedRoboto = false;
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
    if (family.toLowerCase() == 'roboto') {
      loadedRoboto = true;
    }
  }

  // Sécurité : si Roboto n'était pas dans le manifest pour une raison quelconque
  if (!loadedRoboto) {
    try {
      final loader = FontLoader('Roboto');
      loader.addFont(rootBundle.load('assets/fonts/roboto-regular.ttf'));
      loader.addFont(rootBundle.load('assets/fonts/roboto-bold.ttf'));
      await loader.load();
    } catch (_) {}
  }
}
