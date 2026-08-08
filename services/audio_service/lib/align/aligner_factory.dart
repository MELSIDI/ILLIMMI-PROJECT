import 'dart:io';

import 'local_sherpa_aligner.dart';
import 'remote_whisper_aligner.dart';
import 'whispercpp_aligner.dart';
import 'word_aligner.dart';

/// Sélectionne l'implémentation de [WordAligner] via la variable
/// d'environnement `ALIGNER_BACKEND` (`local` | `remote` | `whispercpp`).
///
/// Défaut : `remote` (Whisper OpenAI). Le modèle ONNX requis par
/// [LocalSherpaAligner] (`speaker/whisper/model/*.onnx`) est bien présent
/// dans ce dépôt, mais c'est l'export officiel `sherpa-onnx-whisper-tiny`
/// (releases GitHub k2-fsa/sherpa-onnx) — il ne contient pas les sorties
/// cross-attention nécessaires aux timestamps mot-par-mot, qui reviennent
/// donc vides (voir le commentaire de `_toWordTimestamps` dans
/// `local_sherpa_aligner.dart`). [WhisperCppAligner] (`whispercpp`) est
/// l'alternative locale qui produit de vrais timestamps, via `whisper.cpp`
/// (`speaker/whispercpp/`) plutôt que sherpa-onnx.
WordAligner createAligner() {
  final backend = Platform.environment['ALIGNER_BACKEND'] ?? 'remote';
  switch (backend) {
    case 'local':
      return LocalSherpaAligner();
    case 'remote':
      return RemoteWhisperAligner();
    case 'whispercpp':
      return WhisperCppAligner();
    default:
      throw ArgumentError(
        'ALIGNER_BACKEND invalide: "$backend" (attendu: "local", "remote" ou "whispercpp")',
      );
  }
}
