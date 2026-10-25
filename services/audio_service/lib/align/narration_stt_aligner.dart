import 'dart:math';

import '../models.dart';
import 'narration_parser.dart';
import 'stt_parser.dart';

/// Aligne de manière déterministe et algorithmique la narration (vérité textuelle)
/// avec les tokens Whisper (vérité temporelle).
///
/// Intègre une recherche d'ancre dynamique (Anchor Recovery) garantissant qu'en cas
/// de désynchronisation ponctuelle (ex. acronymes comme P L S Q L, formules, bruits),
/// l'aligneur ne se bloque JAMAIS sur un timestamp unique et se resynchronise automatiquement.
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
    if (narrationKey.isEmpty || sttKey.isEmpty) return false;
    if (narrationKey == sttKey) return true;
    if (_frenchNumberWords[narrationKey] == sttKey) return true;
    if (narrationKey == _frenchNumberWords[sttKey]) return true;
    return false;
  }

  /// Tente de faire correspondre un mot (ou groupe de mots) localement
  _MatchResult? _tryMatchLocal({
    required List<NarrationWord> narrationWords,
    required List<SttToken> sttTokens,
    required int wIdx,
    required int sttIdx,
    int maxLookahead = 3,
  }) {
    final nw = narrationWords[wIdx];
    final target = nw.matchKey;

    // CAS 1 : Plusieurs mots consécutifs de la narration sont regroupés dans UN token STT (ex. " AB")
    if (wIdx + 1 < narrationWords.length && sttIdx < sttTokens.length) {
      final currentStt = sttTokens[sttIdx];
      final nextNw = narrationWords[wIdx + 1];
      final combined2 = target + nextNw.matchKey;

      if (keysMatch(combined2, currentStt.matchKey)) {
        final dur = currentStt.end - currentStt.start;
        final len1 = target.length;
        final len2 = nextNw.matchKey.length;
        final totalLen = max(1, len1 + len2).toDouble();
        final mid = currentStt.start + (dur * (len1 / totalLen));

        return _MatchResult(
          narrationWordsConsumed: 2,
          sttTokensConsumed: 1,
          producedTimestamps: [
            WordTimestamp(
              word: nw.text,
              start: currentStt.start,
              end: mid,
              confidence: 'SPLIT_FROM_STT',
            ),
            WordTimestamp(
              word: nextNw.text,
              start: mid,
              end: currentStt.end,
              confidence: 'SPLIT_FROM_STT',
            ),
          ],
        );
      }
    }

    // CAS 2 : Recherche d'un match exact ou fusionné (subwords) dans une fenêtre d'anticipation
    const maxTokensToMerge = 7;
    for (var lookahead = 0;
        lookahead <= maxLookahead && sttIdx + lookahead < sttTokens.length;
        lookahead++) {
      final startIdx = sttIdx + lookahead;
      if (sttTokens[startIdx].isPunctuation) continue;

      for (var k = 1;
          k <= maxTokensToMerge && startIdx + k <= sttTokens.length;
          k++) {
        final slice = sttTokens.sublist(startIdx, startIdx + k);
        final buf = slice.map((s) => s.matchKey).join('');

        if (keysMatch(target, buf)) {
          final start = slice.first.start;
          var end = slice.last.end;
          var nextStt = startIdx + k;

          // Si le mot termine une phrase et que Whisper a produit un token de ponctuation finale
          // (ex. "." après "Bonjour"), on absorbe ce temps de pause dans le mot terminal.
          if (_sentenceEndRegex.hasMatch(nw.text.trim()) &&
              nextStt < sttTokens.length &&
              sttTokens[nextStt].isPunctuation) {
            end = sttTokens[nextStt].end;
            nextStt++;
          }

          final type = (k == 1 && lookahead == 0) ? 'EXACT' : 'MERGED';
          return _MatchResult(
            narrationWordsConsumed: 1,
            sttTokensConsumed: nextStt - sttIdx,
            producedTimestamps: [
              WordTimestamp(
                word: nw.text,
                start: start,
                end: max(start, end),
                confidence: type,
              ),
            ],
          );
        }
      }
    }

    // CAS 3 : Fuzzy matching pour absorber les petites fautes de transcription
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

    if (bestSim >= 0.65) {
      final slice = sttTokens.sublist(sttIdx, sttIdx + bestK);
      final start = slice.first.start;
      var end = slice.last.end;
      var nextStt = sttIdx + bestK;

      if (_sentenceEndRegex.hasMatch(nw.text.trim()) &&
          nextStt < sttTokens.length &&
          sttTokens[nextStt].isPunctuation) {
        end = sttTokens[nextStt].end;
        nextStt++;
      }

      return _MatchResult(
        narrationWordsConsumed: 1,
        sttTokensConsumed: nextStt - sttIdx,
        producedTimestamps: [
          WordTimestamp(
            word: nw.text,
            start: start,
            end: max(start, end),
            confidence: 'FUZZY',
          ),
        ],
      );
    }

    return null;
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
      // Ignore la ponctuation STT pure en tête avant de chercher un mot
      while (sttIdx < sttTokens.length && sttTokens[sttIdx].isPunctuation) {
        sttIdx++;
      }

      // Si la fin des tokens STT est atteinte, on interpole le reste
      if (sttIdx >= sttTokens.length) {
        final lastEnd = results.isNotEmpty ? results.last.end : 0.0;
        final missingCount = narrationWords.length - wIdx;
        const fallbackWordDuration = 0.30;

        for (var step = 0; step < missingCount; step++) {
          final currentWIdx = wIdx + step;
          final wStart = lastEnd + (step * fallbackWordDuration);
          final wEnd = wStart + (fallbackWordDuration * 0.90);
          results.add(WordTimestamp(
            word: narrationWords[currentWIdx].text,
            start: double.parse(wStart.toStringAsFixed(3)),
            end: double.parse(wEnd.toStringAsFixed(3)),
            confidence: 'UNMATCHED',
          ));
        }
        break;
      }

      // 1. Tente un match local direct
      final localMatch = _tryMatchLocal(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
        wIdx: wIdx,
        sttIdx: sttIdx,
        maxLookahead: 3,
      );

      if (localMatch != null) {
        results.addAll(localMatch.producedTimestamps);
        wIdx += localMatch.narrationWordsConsumed;
        sttIdx += localMatch.sttTokensConsumed;
        continue;
      }

      // 2. Échec du match local : Recherche d'une ancre de resynchronisation (Anchor Recovery)
      // Analyse les prochains mots de la narration (jusqu'à 12 mots) pour trouver un match solide
      // parmi les prochains tokens STT (jusqu'à 50 tokens).
      int? foundAheadWIdx;
      int? foundAheadSttIdx;
      _MatchResult? aheadMatch;

      const maxNarrationSearchAhead = 12;
      const maxSttSearchAhead = 50;

      for (var nwAhead = 1; nwAhead <= maxNarrationSearchAhead && wIdx + nwAhead < narrationWords.length; nwAhead++) {
        final candidateWIdx = wIdx + nwAhead;
        if (narrationWords[candidateWIdx].matchKey.length < 2) continue;

        for (var sttAhead = 1; sttAhead <= maxSttSearchAhead && sttIdx + sttAhead < sttTokens.length; sttAhead++) {
          final candidateSttIdx = sttIdx + sttAhead;
          if (sttTokens[candidateSttIdx].isPunctuation) continue;

          final testMatch = _tryMatchLocal(
            narrationWords: narrationWords,
            sttTokens: sttTokens,
            wIdx: candidateWIdx,
            sttIdx: candidateSttIdx,
            maxLookahead: 0,
          );

          if (testMatch != null) {
            final isLongWord = narrationWords[candidateWIdx].matchKey.length >= 4;
            bool confirmed = isLongWord;

            if (!confirmed && candidateWIdx + 1 < narrationWords.length) {
              final nextSttCandidate = candidateSttIdx + testMatch.sttTokensConsumed;
              if (nextSttCandidate < sttTokens.length) {
                final confirmMatch = _tryMatchLocal(
                  narrationWords: narrationWords,
                  sttTokens: sttTokens,
                  wIdx: candidateWIdx + 1,
                  sttIdx: nextSttCandidate,
                  maxLookahead: 1,
                );
                if (confirmMatch != null) {
                  confirmed = true;
                }
              }
            }

            if (confirmed) {
              foundAheadWIdx = candidateWIdx;
              foundAheadSttIdx = candidateSttIdx;
              aheadMatch = testMatch;
              break;
            }
          }
        }
        if (foundAheadWIdx != null) break;
      }

      if (foundAheadWIdx != null && foundAheadSttIdx != null && aheadMatch != null) {
        // Point d'ancrage trouvé : interpolation linéaire fluide et strictement croissante
        // pour tous les mots non appariés entre le dernier mot validé et cette ancre.
        final spanStart = results.isNotEmpty ? results.last.end : (sttIdx < sttTokens.length ? sttTokens[sttIdx].start : 0.0);
        final spanEnd = aheadMatch.producedTimestamps.first.start;
        final unanchoredCount = foundAheadWIdx - wIdx;

        final safeSpanEnd = spanEnd > spanStart ? spanEnd : (spanStart + (0.15 * unanchoredCount));
        final dt = (safeSpanEnd - spanStart) / unanchoredCount;

        for (var step = 0; step < unanchoredCount; step++) {
          final missingWIdx = wIdx + step;
          final wStart = spanStart + (step * dt);
          final wEnd = min(safeSpanEnd, wStart + (dt * 0.90));
          results.add(WordTimestamp(
            word: narrationWords[missingWIdx].text,
            start: double.parse(wStart.toStringAsFixed(3)),
            end: double.parse(wEnd.toStringAsFixed(3)),
            confidence: 'RECOVERED_INTERPOLATION',
          ));
        }

        results.addAll(aheadMatch.producedTimestamps);
        wIdx = foundAheadWIdx + aheadMatch.narrationWordsConsumed;
        sttIdx = foundAheadSttIdx + aheadMatch.sttTokensConsumed;
        continue;
      }

      // 3. Fallback mot à mot avec progression temporelle (garantit qu'aucun blocage ne se produise)
      final prevEnd = results.isNotEmpty ? results.last.end : (sttIdx < sttTokens.length ? sttTokens[sttIdx].start : 0.0);
      const estDuration = 0.25;
      final nextStart = prevEnd;
      final nextEnd = (sttIdx < sttTokens.length)
          ? max(prevEnd + estDuration, sttTokens[sttIdx].start)
          : prevEnd + estDuration;

      results.add(WordTimestamp(
        word: narrationWords[wIdx].text,
        start: double.parse(nextStart.toStringAsFixed(3)),
        end: double.parse(nextEnd.toStringAsFixed(3)),
        confidence: 'UNMATCHED',
      ));

      wIdx++;
      while (sttIdx < sttTokens.length && sttTokens[sttIdx].start < nextEnd) {
        sttIdx++;
      }
    }

    // Passe de validation et correction finale de cohérence temporelle
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
        end = start + 0.05;
      }
      currentMin = start;

      if (start != words[i].start || end != words[i].end) {
        words[i] = WordTimestamp(
          word: words[i].word,
          start: double.parse(start.toStringAsFixed(3)),
          end: double.parse(end.toStringAsFixed(3)),
          confidence: words[i].confidence,
        );
      }
    }
  }
}

class _MatchResult {
  final int narrationWordsConsumed;
  final int sttTokensConsumed;
  final List<WordTimestamp> producedTimestamps;

  _MatchResult({
    required this.narrationWordsConsumed,
    required this.sttTokensConsumed,
    required this.producedTimestamps,
  });
}
