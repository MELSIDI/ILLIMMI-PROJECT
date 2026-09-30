import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'tts_engine.dart';
export 'tts_engine.dart';

/// Enveloppe le binaire Piper TTS (subprocess Windows natif).
///
/// Les chemins sont configurables par variables d'environnement plutôt que
/// codés en dur, puisque ce service tourne indépendamment du client Flutter :
/// `PIPER_EXE_PATH`, `PIPER_MODEL_PATH`, `AUDIO_OUTPUT_DIR` (par défaut,
/// relatifs à `Directory.current.path`, la racine de ce service).
class PiperServices implements TtsEngine {
  late final String piperPath;
  late final String modelPath;
  @override
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

  @override
  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
    String? preferredProvider,
  }) async {
    if (!File(piperPath).existsSync()) {
      print('❌ ERREUR : Exécutable introuvable à : $piperPath');
      return null;
    }

    final fullDirectoryPath = p.join(outputDir, dirName);
    final fullFilePath = p.join(fullDirectoryPath, '$fileName.wav');

    final file = File(fullFilePath);
    if (await file.exists()) {
      return TtsResults(file: file, duration: await readWavDurationSeconds(file));
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

      if (await process.exitCode == 0) {
        final wavFile = File(fullFilePath);
        final dur = extractedDuration ?? await readWavDurationSeconds(wavFile);
        return TtsResults(file: wavFile, duration: dur);
      }
    } catch (e) {
      print('❌ Erreur lors du lancement du processus : $e');
    }
    return null;
  }
}
