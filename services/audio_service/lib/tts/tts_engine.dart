import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Résultat d'une synthèse vocale : fichier généré et durée en secondes.
class TtsResults {
  File? file;
  double duration;
  TtsResults({this.file, this.duration = -1});
}

/// Interface commune pour les moteurs TTS (Piper local, OpenRouter distant, etc.).
abstract class TtsEngine {
  /// Répertoire racine où les fichiers audios sont stockés.
  String get outputDir;

  /// Synthétise le texte donné dans un fichier audio sous [outputDir]/[dirName]/[fileName].wav.
  /// [preferredProvider] permet d'outrepasser ponctuellement le provider configuré.
  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
    String? preferredProvider,
  });
}

/// Lit la durée d'un WAV PCM directement depuis son en-tête (chunks `fmt ` et `data`).
Future<double> readWavDurationSeconds(File file) async {
  final bytes = await file.readAsBytes();
  final data = ByteData.view(bytes.buffer, bytes.offsetInBytes, bytes.length);

  int sampleRate = 0;
  int channels = 0;
  int bitsPerSample = 0;
  int dataSize = 0;

  var offset = 12; // après "RIFF"<size>"WAVE"
  while (offset + 8 <= bytes.length) {
    final chunkId = ascii.decode(bytes.sublist(offset, offset + 4));
    final chunkSize = data.getUint32(offset + 4, Endian.little);
    final chunkStart = offset + 8;

    if (chunkId == 'fmt ') {
      channels = data.getUint16(chunkStart + 2, Endian.little);
      sampleRate = data.getUint32(chunkStart + 4, Endian.little);
      bitsPerSample = data.getUint16(chunkStart + 14, Endian.little);
    } else if (chunkId == 'data') {
      dataSize = chunkSize;
    }

    offset = chunkStart + chunkSize + (chunkSize.isOdd ? 1 : 0);
  }

  if (sampleRate == 0 || channels == 0 || bitsPerSample == 0) return -1;
  final bytesPerSecond = sampleRate * channels * (bitsPerSample ~/ 8);
  if (bytesPerSecond == 0) return -1;
  return dataSize / bytesPerSecond;
}
