import '../models.dart';

/// Aligne un fichier audio avec des timestamps mot-par-mot.
///
/// Deux implémentations interchangeables : [LocalSherpaAligner] (local,
/// léger, via sherpa_onnx) et [RemoteWhisperAligner] (API Whisper d'OpenAI).
abstract class WordAligner {
  Future<List<WordTimestamp>> align({required String wavPath});
}
