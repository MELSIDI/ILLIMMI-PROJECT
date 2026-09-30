import '../models.dart';

/// Aligne un fichier audio avec des timestamps mot-par-mot.
///
/// Implémentations : [WhisperCppAligner] (local whisper.cpp),
/// [RemoteWhisperAligner] (API Whisper d'OpenAI) et [LocalSherpaAligner].
abstract class WordAligner {
  Future<List<WordTimestamp>> align({
    required String wavPath,
    String? narrationText,
    String? narrationPath,
  });
}
