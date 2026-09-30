import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'tts_engine.dart';

/// Service de synthèse vocale utilisant l'API Text-to-Speech d'OpenRouter.
/// Endpoint : `POST https://openrouter.ai/api/v1/audio/speech`
/// Modèles recommandés : deepgram/aura-2 (voix: aura-2-agathe-fr, aura-2-hector-fr), hexgrad/kokoro-82m (voix: ff_siwis).
class OpenRouterTtsService implements TtsEngine {
  static const String _defaultModel = 'deepgram/aura-2';
  static const String _defaultVoice = 'aura-2-agathe-fr';
  static const String _endpoint = 'https://openrouter.ai/api/v1/audio/speech';

  @override
  final String outputDir;

  String get model => Platform.environment['OPENROUTER_TTS_MODEL'] ?? _defaultModel;
  String get voice => Platform.environment['OPENROUTER_TTS_VOICE'] ?? _defaultVoice;

  String? get apiKey => Platform.environment['OPENROUTER_API_KEY'];

  OpenRouterTtsService({String? outputDir})
      : outputDir = outputDir ??
            Platform.environment['AUDIO_OUTPUT_DIR'] ??
            p.join(Directory.current.path, 'speaker', 'audios') {
    Directory(this.outputDir).createSync(recursive: true);
  }

  @override
  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
    String? preferredProvider,
  }) async {
    final key = apiKey;
    if (key == null || key.isEmpty) {
      throw Exception('OPENROUTER_API_KEY non configurée pour OpenRouter TTS.');
    }

    final fullDirectoryPath = p.join(outputDir, dirName);
    final wavPath = p.join(fullDirectoryPath, '$fileName.wav');
    final wavFile = File(wavPath);

    if (await wavFile.exists()) {
      return TtsResults(
        file: wavFile,
        duration: await readWavDurationSeconds(wavFile),
      );
    }

    await Directory(fullDirectoryPath).create(recursive: true);

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $key',
        'HTTP-Referer': 'https://illimmi.app',
        'X-Title': 'ILLIMMI',
      },
      body: jsonEncode({
        'model': model,
        'input': text,
        'voice': voice,
        'response_format': 'mp3',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erreur OpenRouter TTS (${response.statusCode}): ${response.body}',
      );
    }

    final mp3Path = p.join(fullDirectoryPath, '$fileName.temp.mp3');
    final mp3File = File(mp3Path);
    await mp3File.writeAsBytes(response.bodyBytes);

    try {
      // Conversion MP3 vers WAV 16kHz mono (optimisé pour whispercpp / alignement)
      final ffmpegResult = await Process.run('ffmpeg', [
        '-y',
        '-i',
        mp3Path,
        '-ar',
        '16000',
        '-ac',
        '1',
        '-c:a',
        'pcm_s16le',
        wavPath,
      ]);

      if (ffmpegResult.exitCode != 0) {
        throw Exception('Erreur ffmpeg lors de la conversion audio: ${ffmpegResult.stderr}');
      }
    } finally {
      if (await mp3File.exists()) {
        try {
          await mp3File.delete();
        } catch (_) {}
      }
    }

    final finalWav = File(wavPath);
    if (!await finalWav.exists()) {
      throw Exception('Fichier audio WAV non généré : $wavPath');
    }

    final duration = await readWavDurationSeconds(finalWav);
    return TtsResults(file: finalWav, duration: duration);
  }
}
