import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../models.dart';
import 'word_aligner.dart';

import 'compact_timeline.dart';
import 'narration_parser.dart';
import 'narration_stt_aligner.dart';
import 'stt_parser.dart';

/// Alignement mot-par-mot local via `whisper.cpp` (CLI), en subprocess.
///
/// Contrairement à [LocalSherpaAligner] (l'export ONNX officiel
/// `sherpa-onnx-whisper-tiny` ne contient pas les sorties cross-attention
/// nécessaires aux timestamps — voir son commentaire), `whisper-cli.exe`
/// produit de vrais timestamps par token via `-ml 1` (max-len 1). whisper.cpp
/// exige un wav 16 kHz mono 16 bits en entrée ; Piper produit du 22050 Hz, on
/// convertit donc d'abord avec `ffmpeg`.
class WhisperCppAligner implements WordAligner {
  static final _punctuationOnly = RegExp(r'^[.,;:!?…»«"()]+$');

  late final String whisperCliPath;
  late final String modelPath;
  late final String ffmpegPath;

  final NarrationParser _narrationParser = NarrationParser();
  final SttParser _sttParser = SttParser();
  final NarrationSttAligner _narrationAligner = NarrationSttAligner();
  final CompactTimelineWriter _timelineWriter = const CompactTimelineWriter();

  WhisperCppAligner() {
    final root = Directory.current.path;
    final env = Platform.environment;

    whisperCliPath =
        env['WHISPERCPP_EXE_PATH'] ??
        p.join(root, 'speaker', 'whispercpp', 'Release', 'whisper-cli.exe');
    modelPath =
        env['WHISPERCPP_MODEL_PATH'] ??
        p.join(root, 'speaker', 'whispercpp', 'models', 'ggml-small.bin');
    ffmpegPath = env['FFMPEG_EXE_PATH'] ?? 'ffmpeg';
  }

  @override
  Future<List<WordTimestamp>> align({
    required String wavPath,
    String? narrationText,
    String? narrationPath,
  }) async {
    final wav16k = '${p.withoutExtension(wavPath)}_16k.wav';
    final ffmpegResult = await Process.run(ffmpegPath, [
      '-y',
      '-i', wavPath,
      '-ar', '16000',
      '-ac', '1',
      '-c:a', 'pcm_s16le',
      wav16k,
    ]);
    if (ffmpegResult.exitCode != 0) {
      throw Exception('Échec de la conversion ffmpeg : ${ffmpegResult.stderr}');
    }

    final outBase = '${p.withoutExtension(wavPath)}_words';
    final whisperResult = await Process.run(whisperCliPath, [
      '-m', modelPath,
      '-f', wav16k,
      '-l', 'fr',
      '-ml', '1',
      '-oj',
      '-of', outBase,
    ]);
    if (whisperResult.exitCode != 0) {
      throw Exception('Échec de whisper-cli : ${whisperResult.stderr}');
    }

    final data =
        jsonDecode(await File('$outBase.json').readAsString())
            as Map<String, dynamic>;
    final tokens = (data['transcription'] as List).cast<Map<String, dynamic>>();

    // 1. Résolution de la narration (source de vérité textuelle)
    var resolvedNarration = narrationText;
    if (resolvedNarration == null || resolvedNarration.trim().isEmpty) {
      if (narrationPath != null && await File(narrationPath).exists()) {
        resolvedNarration = await File(narrationPath).readAsString();
      } else {
        final dir = p.dirname(wavPath);
        final defaultNarration = File(p.join(dir, 'narration.txt'));
        final siblingTxt = File('${p.withoutExtension(wavPath)}.txt');
        if (await defaultNarration.exists()) {
          resolvedNarration = await defaultNarration.readAsString();
        } else if (await siblingTxt.exists()) {
          resolvedNarration = await siblingTxt.readAsString();
        }
      }
    }

    List<WordTimestamp> resultWords;

    if (resolvedNarration != null && resolvedNarration.trim().isNotEmpty) {
      // 2. Alignement structuré : Narration (texte) ↔ Whisper (temps)
      final narrationWords = _narrationParser.parse(resolvedNarration);
      final sttTokens = _sttParser.parseTokens(tokens);
      resultWords = _narrationAligner.align(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
      );
    } else {
      // Fallback si aucune narration n'est fournie
      resultWords = _mergeTokensIntoWords(tokens);
    }

    // 3. Sauvegarde de la timeline compacte
    final compactFile = File('$outBase.txt');
    await _timelineWriter.writeToFile(compactFile, resultWords);

    // Si on est dans le dossier vecteurs, assure la présence de vecteur_words.txt et vecteurs_words.txt
    if (p.basenameWithoutExtension(wavPath).toLowerCase().contains('vecteur')) {
      final altFile = File(p.join(p.dirname(wavPath), 'vecteur_words.txt'));
      if (altFile.path != compactFile.path) {
        await _timelineWriter.writeToFile(altFile, resultWords);
      }
      final altFilePlural = File(p.join(p.dirname(wavPath), 'vecteurs_words.txt'));
      if (altFilePlural.path != compactFile.path) {
        await _timelineWriter.writeToFile(altFilePlural, resultWords);
      }
    }

    return resultWords;
  }

  /// whisper.cpp découpe en tokens de sous-mots : un token qui commence par
  /// une espace démarre un nouveau mot, sinon il prolonge le précédent (ex.
  /// `" bien"` + `"venue"` → `"bienvenue"`). La ponctuation isolée (ex. `" ."`)
  /// est elle aussi recollée au mot précédent plutôt que de former une entrée
  /// à part.
  List<WordTimestamp> _mergeTokensIntoWords(List<Map<String, dynamic>> tokens) {
    final words = <WordTimestamp>[];
    String? currentWord;
    double currentStart = 0;
    double currentEnd = 0;

    for (final token in tokens) {
      final text = token['text'] as String;
      final trimmed = text.trim();
      if (trimmed.isEmpty) continue;

      final offsets = token['offsets'] as Map<String, dynamic>;
      final start = (offsets['from'] as num) / 1000.0;
      final end = (offsets['to'] as num) / 1000.0;

      final isContinuation =
          currentWord != null &&
          (!text.startsWith(' ') || _punctuationOnly.hasMatch(trimmed));

      if (isContinuation) {
        currentWord = '$currentWord$trimmed';
        currentEnd = end;
      } else {
        if (currentWord != null) {
          words.add(WordTimestamp(word: currentWord, start: currentStart, end: currentEnd));
        }
        currentWord = trimmed;
        currentStart = start;
        currentEnd = end;
      }
    }
    if (currentWord != null) {
      words.add(WordTimestamp(word: currentWord, start: currentStart, end: currentEnd));
    }
    return words;
  }
}
