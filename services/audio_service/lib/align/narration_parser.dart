/// Représente un mot issu de la narration textuelle originale (source de vérité textuelle).
class NarrationWord {
  final int index;
  final String text; // Forme textuelle finale exacte (ex. "Bonjour !", "cours,", "construire")
  final String cleanWord; // Mot débarrassé de la ponctuation (ex. "Bonjour", "cours", "construire")
  final String matchKey; // Clé normalisée pour l'alignement (ex. "bonjour", "cours", "construire")

  NarrationWord({
    required this.index,
    required this.text,
    required this.cleanWord,
    required this.matchKey,
  });

  @override
  String toString() => text;
}

/// Découpe une narration en une séquence de [NarrationWord] en respectant les règles
/// typographiques françaises (ponctuations doubles avec espace précédant, élisions, etc.).
class NarrationParser {
  static final RegExp _punctRegex = RegExp(r'^[.,;:!?…»«"()]+$');
  static final RegExp _surroundingPunctRegex =
      RegExp(r'^[.,;:!?…»«"()\s]+|[.,;:!?…»«"()\s]+$');

  /// Normalise une chaîne pour la comparaison tolérante dans l'aligneur
  static String normalizeKey(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r"[’']"), "")
        .replaceAll(RegExp(r"[^a-z0-9àâäéèêëîïôöùûüç]"), "");
  }

  /// Parse le texte de narration complet
  List<NarrationWord> parse(String text) {
    final lines = text.split('\n');
    final rawTokens = <String>[];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      // Découpage par espaces
      rawTokens.addAll(trimmed.split(RegExp(r'\s+')));
    }

    final words = <NarrationWord>[];
    var wordIdx = 0;

    for (var i = 0; i < rawTokens.length; i++) {
      final token = rawTokens[i];

      // Si le token est une ponctuation isolée (ex. "!", ":", ";", "?", "...")
      // en typographie française, on la rattache au mot précédent.
      if (_punctRegex.hasMatch(token)) {
        if (words.isNotEmpty) {
          final prev = words.removeLast();
          final newText = '${prev.text} $token';
          words.add(NarrationWord(
            index: prev.index,
            text: newText,
            cleanWord: prev.cleanWord,
            matchKey: prev.matchKey,
          ));
        }
      } else {
        final clean = token.replaceAll(_surroundingPunctRegex, '').trim();
        final matchKey = normalizeKey(clean.isNotEmpty ? clean : token);

        words.add(NarrationWord(
          index: wordIdx++,
          text: token,
          cleanWord: clean.isNotEmpty ? clean : token,
          matchKey: matchKey,
        ));
      }
    }

    return words;
  }
}
