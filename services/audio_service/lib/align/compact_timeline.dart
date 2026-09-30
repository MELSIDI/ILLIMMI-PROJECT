import 'dart:io';

import '../models.dart';

/// Écrit une chronologie mot-par-mot au format compact `<start>mot<end>`
/// permettant une réduction massive du nombre de tokens (remplace les JSON verbeux).
class CompactTimelineWriter {
  final int decimals;

  const CompactTimelineWriter({this.decimals = 3});

  /// Convertit la liste de mots en chaîne de texte compacte
  String writeToString(List<WordTimestamp> words) {
    final buffer = StringBuffer();
    for (final w in words) {
      buffer.writeln(w.toCompact(decimals));
    }
    return buffer.toString();
  }

  /// Écrit directement dans un fichier texte (ex. `vecteur_words.txt`)
  Future<void> writeToFile(File file, List<WordTimestamp> words) async {
    await file.parent.create(recursive: true);
    await file.writeAsString(writeToString(words));
  }
}

/// Lit et parse un fichier ou une chaîne au format compact `<start>mot<end>`.
class CompactTimelineReader {
  const CompactTimelineReader();

  /// Parse le contenu textuel complet
  List<WordTimestamp> readFromString(String content) {
    final lines = content.split('\n');
    final words = <WordTimestamp>[];

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      try {
        words.add(WordTimestamp.fromCompact(line));
      } catch (e) {
        throw FormatException('Erreur à la ligne ${i + 1} de la timeline compacte : $e');
      }
    }

    return words;
  }

  /// Parse un fichier texte existant
  Future<List<WordTimestamp>> readFromFile(File file) async {
    final content = await file.readAsString();
    return readFromString(content);
  }
}
