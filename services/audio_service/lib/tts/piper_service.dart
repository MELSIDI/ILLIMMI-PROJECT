import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

class TtsResults {
  File? file;
  double duration;
  TtsResults({this.file, this.duration = -1});
}

/// Enveloppe le binaire Piper TTS (subprocess Windows natif).
///
/// Les chemins sont configurables par variables d'environnement plutôt que
/// codés en dur, puisque ce service tourne indépendamment du client Flutter :
/// `PIPER_EXE_PATH`, `PIPER_MODEL_PATH`, `AUDIO_OUTPUT_DIR` (par défaut,
/// relatifs à `Directory.current.path`, la racine de ce service).
class PiperServices {
  late final String piperPath;
  late final String modelPath;
  late final String outputDir;

  PiperServices() {
    final root = Directory.current.path;
    final env = Platform.environment;

    piperPath =
        env['PIPER_EXE_PATH'] ?? p.join(root, 'speaker', 'piper', 'piper.exe');
    modelPath =
        env['PIPER_MODEL_PATH'] ??
        p.join(root, 'speaker', 'piper', 'model', 'fr_FR-siwis-medium.onnx');
    outputDir = env['AUDIO_OUTPUT_DIR'] ?? p.join(root, 'speaker', 'audios');
    Directory(outputDir).createSync(recursive: true);
  }

  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
  }) async {
    if (!File(piperPath).existsSync()) {
      print('❌ ERREUR : Exécutable introuvable à : $piperPath');
      return null;
    }

    final fullDirectoryPath = p.join(outputDir, dirName);
    final fullFilePath = p.join(fullDirectoryPath, '$fileName.wav');

    final file = File(fullFilePath);
    if (await file.exists()) {
      return TtsResults(file: file, duration: await _wavDurationSeconds(file));
    }

    await Directory(fullDirectoryPath).create(recursive: true);

    try {
      final process = await Process.start(piperPath, [
        '-m',
        modelPath,
        '--output_file',
        fullFilePath,
      ]);

      double? extractedDuration;

      process.stderr.transform(utf8.decoder).listen((line) {
        if (line.contains('audio=')) {
          final match = RegExp(r'audio=([\d.]+)').firstMatch(line);
          if (match != null) {
            extractedDuration = double.tryParse(match.group(1)!);
          }
        }
      });

      process.stdin.write(text);
      await process.stdin.close();

      if (await process.exitCode == 0 && extractedDuration != null) {
        return TtsResults(file: File(fullFilePath), duration: extractedDuration!);
      }
    } catch (e) {
      print('❌ Erreur lors du lancement du processus : $e');
    }
    return null;
  }

  /// Lit la durée d'un WAV PCM directement depuis son en-tête (chunks `fmt `
  /// et `data`) — remplace la sonde `audioplayers` de la version monolithe,
  /// qui dépend du moteur Flutter et n'est pas utilisable dans ce serveur
  /// Dart pur.
  Future<double> _wavDurationSeconds(File file) async {
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
}
