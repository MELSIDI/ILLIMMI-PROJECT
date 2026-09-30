import 'dart:convert';
import 'dart:io';

/// Représente un fragment ou token audio produit par STT / Whisper (source de vérité temporelle).
class SttToken {
  final int index;
  final String rawText;
  final String trimmed;
  final double start;
  final double end;
  final bool isPunctuation;
  final bool startsWithSpace;
  final String matchKey;

  SttToken({
    required this.index,
    required this.rawText,
    required this.trimmed,
    required this.start,
    required this.end,
    required this.isPunctuation,
    required this.startsWithSpace,
    required this.matchKey,
  });

  @override
  String toString() => '<${start.toStringAsFixed(3)}>$trimmed<${end.toStringAsFixed(3)}>';
}

/// Parse et normalise les tokens STT bruts issus de Whisper/STT.
class SttParser {
  static final RegExp _punctRegex = RegExp(r'^[.,;:!?…»«"()]+$');

  static String normalizeKey(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r"[’']"), "")
        .replaceAll(RegExp(r"[^a-z0-9àâäéèêëîïôöùûüç]"), "");
  }

  /// Parse à partir de la liste brute de tokens (format whisper.cpp JSON `transcription`)
  List<SttToken> parseTokens(List<Map<String, dynamic>> rawTokens) {
    final tokens = <SttToken>[];

    for (var i = 0; i < rawTokens.length; i++) {
      final t = rawTokens[i];
      final text = (t['text'] as String?) ?? '';
      final trimmed = text.trim();
      if (trimmed.isEmpty) continue; // Ignore les tokens STT vides

      final offsets = t['offsets'] as Map<String, dynamic>?;
      final start = offsets != null
          ? ((offsets['from'] as num).toDouble() / 1000.0)
          : ((t['start'] as num?)?.toDouble() ?? 0.0);
      final end = offsets != null
          ? ((offsets['to'] as num).toDouble() / 1000.0)
          : ((t['end'] as num?)?.toDouble() ?? start);

      final startsWithSpace = text.startsWith(' ');
      final isPunct = _punctRegex.hasMatch(trimmed);
      final matchKey = normalizeKey(trimmed);

      tokens.add(SttToken(
        index: i,
        rawText: text,
        trimmed: trimmed,
        start: start,
        end: end,
        isPunctuation: isPunct,
        startsWithSpace: startsWithSpace,
        matchKey: matchKey,
      ));
    }

    return tokens;
  }

  /// Parse à partir d'un fichier JSON whisper.cpp
  Future<List<SttToken>> parseJsonFile(File file) async {
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    final rawTokens = (json['transcription'] as List).cast<Map<String, dynamic>>();
    return parseTokens(rawTokens);
  }
}
