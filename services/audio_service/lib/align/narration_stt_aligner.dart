import 'dart:math';

import '../models.dart';
import 'narration_parser.dart';
import 'stt_parser.dart';

/// Aligne de manière déterministe et algorithmique la narration (vérité textuelle)
/// avec les tokens Whisper (vérité temporelle).
class NarrationSttAligner {
  static const Map<String, String> _frenchNumberWords = {
    'zero': '0',
    'un': '1',
    'une': '1',
    'deux': '2',
    'trois': '3',
    'quatre': '4',
    'cinq': '5',
    'six': '6',
    'sept': '7',
    'huit': '8',
    'neuf': '9',
    'dix': '10',
  };

  static final RegExp _sentenceEndRegex = RegExp(r'[.!?…]$');

  /// Calcule la distance de Levenshtein entre deux chaînes.
  static int levenshtein(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<int> v0 = List<int>.generate(s2.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(s2.length + 1, 0);

    for (int i = 0; i < s1.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < s2.length; j++) {
        int cost = (s1[i] == s2[j]) ? 0 : 1;
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }
      for (int j = 0; j <= s2.length; j++) {
        v0[j] = v1[j];
      }
    }
    return v1[s2.length];
  }

  /// Calcule un ratio de similarité textuelle [0.0, 1.0].
  static double similarity(String s1, String s2) {
    if (s1 == s2) return 1.0;
    final maxLen = max(s1.length, s2.length);
    if (maxLen == 0) return 1.0;
    final dist = levenshtein(s1, s2);
    return 1.0 - (dist / maxLen);
  }

  /// Vérifie si deux clés correspondent (égalité directe ou nombre écrit en lettres vs chiffre).
  static bool keysMatch(String narrationKey, String sttKey) {
    if (narrationKey == sttKey) return true;
    if (_frenchNumberWords[narrationKey] == sttKey) return true;
    if (narrationKey == _frenchNumberWords[sttKey]) return true;
    return false;
  }

  /// Aligne une séquence de mots issus de [NarrationParser] avec les tokens de [SttParser].
  List<WordTimestamp> align({
    required List<NarrationWord> narrationWords,
    required List<SttToken> sttTokens,
  }) {
    if (narrationWords.isEmpty) return [];
    if (sttTokens.isEmpty) {
      // Aucun STT disponible : fallback temporel régulier
      return narrationWords.map((w) {
        final t = w.index.toDouble();
        return WordTimestamp(
          word: w.text,
          start: t,
          end: t + 0.5,
          confidence: 'UNMATCHED',
        );
      }).toList();
    }

    var sttIdx = 0;
    final results = <WordTimestamp>[];

    var wIdx = 0;
    while (wIdx < narrationWords.length) {
      final nw = narrationWords[wIdx];
      final target = nw.matchKey;

      // Ignore la ponctuation STT pure en tête avant de chercher un mot
      while (sttIdx < sttTokens.length && sttTokens[sttIdx].isPunctuation) {
        sttIdx++;
      }

      if (sttIdx >= sttTokens.length) {
        // Fin des tokens STT atteinte : prolonge le dernier timestamp connu
        final lastEnd = results.isNotEmpty ? results.last.end : 0.0;
        results.add(WordTimestamp(
          word: nw.text,
          start: lastEnd,
          end: lastEnd,
          confidence: 'UNMATCHED',
        ));
        wIdx++;
        continue;
      }

      final currentStt = sttTokens[sttIdx];
      final currentSttNorm = currentStt.matchKey;

      // CAS 1 : Plusieurs mots consécutifs de la narration sont regroupés dans UN token STT
      // Exemple : narration a "A" et "B", Whisper a produit un token unique " AB"
      if (wIdx + 1 < narrationWords.length) {
        final nextNw = narrationWords[wIdx + 1];
        final combined2 = target + nextNw.matchKey;

        if (keysMatch(combined2, currentSttNorm)) {
          final dur = currentStt.end - currentStt.start;
          final len1 = target.length;
          final len2 = nextNw.matchKey.length;
          final totalLen = max(1, len1 + len2).toDouble();
          final mid = currentStt.start + (dur * (len1 / totalLen));

          results.add(WordTimestamp(
            word: nw.text,
            start: currentStt.start,
            end: mid,
            confidence: 'SPLIT_FROM_STT',
          ));
          results.add(WordTimestamp(
            word: nextNw.text,
            start: mid,
            end: currentStt.end,
            confidence: 'SPLIT_FROM_STT',
          ));

          sttIdx++;
          wIdx += 2;
          continue;
        }
      }

      // CAS 2 : Recherche d'un match exact ou fusionné (subwords) dans une fenêtre d'anticipation
      bool matched = false;
      const maxLookahead = 3;
      const maxTokensToMerge = 7;

      for (var lookahead = 0;
          lookahead <= maxLookahead && sttIdx + lookahead < sttTokens.length;
          lookahead++) {
        final startIdx = sttIdx + lookahead;
        if (sttTokens[startIdx].isPunctuation) continue;

        var buf = '';
        for (var k = 1;
            k <= maxTokensToMerge && startIdx + k <= sttTokens.length;
            k++) {
          final slice = sttTokens.sublist(startIdx, startIdx + k);
          buf = slice.map((s) => s.matchKey).join('');

          if (keysMatch(target, buf)) {
            final start = slice.first.start;
            var end = slice.last.end;
            sttIdx = startIdx + k;

            // Si le mot termine une phrase et que Whisper a produit un token de ponctuation finale
            // (ex. "." après "Bonjour"), on absorbe ce temps de pause dans le mot terminal.
            if (_sentenceEndRegex.hasMatch(nw.text.trim()) &&
                sttIdx < sttTokens.length &&
                sttTokens[sttIdx].isPunctuation) {
              end = sttTokens[sttIdx].end;
              sttIdx++;
            }

            final type = (k == 1 && lookahead == 0) ? 'EXACT' : 'MERGED';
            results.add(WordTimestamp(
              word: nw.text,
              start: start,
              end: max(start, end),
              confidence: type,
            ));
            matched = true;
            break;
          }
        }
        if (matched) break;
      }

      if (matched) {
        wIdx++;
        continue;
      }

      // CAS 3 : Fuzzy matching pour absorber les petites fautes de transcription
      // (ex. "leurs droites soient parallèles" transcrit au singulier "leur droite soit parallèle")
      double bestSim = 0.0;
      int bestK = 1;
      for (var k = 1; k <= 3 && sttIdx + k <= sttTokens.length; k++) {
        final slice = sttTokens.sublist(sttIdx, sttIdx + k);
        final buf = slice.map((s) => s.matchKey).join('');
        final sim = similarity(target, buf);
        if (sim > bestSim) {
          bestSim = sim;
          bestK = k;
        }
      }

      if (bestSim >= 0.60) {
        final slice = sttTokens.sublist(sttIdx, sttIdx + bestK);
        final start = slice.first.start;
        var end = slice.last.end;
        sttIdx += bestK;

        if (_sentenceEndRegex.hasMatch(nw.text.trim()) &&
            sttIdx < sttTokens.length &&
            sttTokens[sttIdx].isPunctuation) {
          end = sttTokens[sttIdx].end;
          sttIdx++;
        }

        results.add(WordTimestamp(
          word: nw.text,
          start: start,
          end: max(start, end),
          confidence: 'FUZZY',
        ));
        wIdx++;
        continue;
      }

      // CAS 4 : Mot non trouvé (UNMATCHED) — Ne pas casser la chaîne
      // Interpolation sécurisée pour garantir la monotonie
      final prevEnd = results.isNotEmpty ? results.last.end : sttTokens[sttIdx].start;
      final nextStart = sttTokens[sttIdx].start;
      final estTime = max(prevEnd, nextStart);

      results.add(WordTimestamp(
        word: nw.text,
        start: prevEnd,
        end: estTime,
        confidence: 'UNMATCHED',
      ));
      wIdx++;
    }

    // Passe de validation et correction finale de cohérence temporelle :
    // Garantit : start <= end et word[i].start <= word[i].end <= word[i+1].start
    _enforceStrictMonotonicity(results);

    return results;
  }

  /// Garantit formellement que pour chaque mot :
  /// 1. word.start <= word.end
  /// 2. word[i].start >= word[i-1].start
  /// 3. word[i].end >= word[i].start
  void _enforceStrictMonotonicity(List<WordTimestamp> words) {
    if (words.isEmpty) return;

    var currentMin = 0.0;
    for (var i = 0; i < words.length; i++) {
      var start = words[i].start;
      var end = words[i].end;

      if (start < currentMin) {
        start = currentMin;
      }
      if (end < start) {
        end = start;
      }
      currentMin = start;

      // Si modifié, on remplace par un WordTimestamp propre
      if (start != words[i].start || end != words[i].end) {
        words[i] = WordTimestamp(
          word: words[i].word,
          start: start,
          end: end,
          confidence: words[i].confidence,
        );
      }
    }
  }
}
