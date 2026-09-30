import 'package:path/path.dart' as p;
import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa;
import 'dart:io';

import '../models.dart';
import 'word_aligner.dart';

/// Alignement mot-par-mot local et léger, via `sherpa_onnx` avec un petit
/// modèle Whisper multilingue en ONNX.
///
/// Nécessite que `speaker/whisper/model/` contienne `encoder.onnx`,
/// `decoder.onnx` et `tokens.txt` — un export ONNX multilingue de type
/// `sherpa-onnx-whisper-tiny` (pas la variante `.en`, les transcripts sont en
/// français), disponible sur les releases GitHub de k2-fsa/sherpa-onnx.
///
/// Les timestamps sont par token (sous-mot Whisper), pas parfaitement au mot
/// — approximatif mais suffisant pour la règle des 0.2–0.5s de la doc.
class LocalSherpaAligner implements WordAligner {
  static bool _bindingsInitialized = false;

  @override
  Future<List<WordTimestamp>> align({
    required String wavPath,
    String? narrationText,
    String? narrationPath,
  }) async {
    if (!_bindingsInitialized) {
      sherpa.initBindings();
      _bindingsInitialized = true;
    }

    final modelDir = p.join(
      Directory.current.path,
      'speaker',
      'whisper',
      'model',
    );
    final encoder = p.join(modelDir, 'encoder.onnx');
    final decoder = p.join(modelDir, 'decoder.onnx');
    final tokens = p.join(modelDir, 'tokens.txt');

    if (!await File(encoder).exists() ||
        !await File(decoder).exists() ||
        !await File(tokens).exists()) {
      throw Exception(
        'Modèle Whisper local introuvable dans $modelDir. '
        'Place-y encoder.onnx, decoder.onnx et tokens.txt '
        '(export ONNX multilingue "sherpa-onnx-whisper-tiny").',
      );
    }

    final recognizer = sherpa.OfflineRecognizer(
      sherpa.OfflineRecognizerConfig(
        model: sherpa.OfflineModelConfig(
          whisper: sherpa.OfflineWhisperModelConfig(
            encoder: encoder,
            decoder: decoder,
            language: 'fr',
            enableTokenTimestamps: true,
          ),
          tokens: tokens,
          modelType: 'whisper',
        ),
      ),
    );

    try {
      final wave = sherpa.readWave(wavPath);
      final stream = recognizer.createStream();
      stream.acceptWaveform(samples: wave.samples, sampleRate: wave.sampleRate);
      recognizer.decode(stream);
      final result = recognizer.getResult(stream);
      stream.free();

      return _toWordTimestamps(result.tokens, result.timestamps);
    } finally {
      recognizer.free();
    }
  }

  /// Convertit les tokens/timestamps sherpa-onnx (un timestamp de début par
  /// token) en [WordTimestamp] : la fin d'un token est le début du suivant
  /// (ou +0.3s par défaut pour le dernier).
  ///
  /// L'export ONNX officiel `sherpa-onnx-whisper-tiny` (releases GitHub
  /// k2-fsa/sherpa-onnx) ne contient pas les sorties cross-attention
  /// nécessaires à `enable_token_timestamps` — sherpa-onnx désactive alors
  /// silencieusement les timestamps et renvoie `timestamps` vide même quand
  /// `tokens` ne l'est pas (il faudrait ré-exporter le modèle avec
  /// `scripts/whisper/export-onnx-with-attention.py` pour les avoir). Dans ce
  /// cas on renvoie une liste vide plutôt que de planter sur un accès hors
  /// bornes ; à l'appelant de gérer l'absence de timestamps (ex. estimation
  /// approximative à partir du texte source et de la durée audio).
  List<WordTimestamp> _toWordTimestamps(
    List<String> tokens,
    List<double> timestamps,
  ) {
    if (timestamps.length < tokens.length) return [];

    final result = <WordTimestamp>[];
    for (var i = 0; i < tokens.length; i++) {
      final word = tokens[i].trim();
      if (word.isEmpty) continue;
      final start = timestamps[i];
      final end = i + 1 < timestamps.length ? timestamps[i + 1] : start + 0.3;
      result.add(WordTimestamp(word: word, start: start, end: end));
    }
    return result;
  }
}
