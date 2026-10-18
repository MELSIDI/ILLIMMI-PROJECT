import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import '../lib/align/compact_timeline.dart';
import '../lib/align/narration_parser.dart';
import '../lib/align/narration_stt_aligner.dart';
import '../lib/align/stt_parser.dart';
import '../lib/align/whispercpp_aligner.dart';
import '../lib/tts/piper_service.dart';

/// CLI pour générer l'audio d'un cours via Piper TTS et aligner mot-par-mot
/// de façon acoustique et déterministe avec Whisper.cpp + NarrationSttAligner.
///
/// Utilisation :
/// dart run bin/align_course_cli.dart \
///   --narration <chemin_vers_narration.txt> \
///   --output-txt <chemin_vers_words.txt> \
///   [--output-wav <chemin_vers_audio.wav>] \
///   [--lang <fr|en>]
Future<void> main(List<String> args) async {
  String? narrationPath;
  String? outputTxtPath;
  String? outputWavPath;
  String lang = 'fr';
  String? piperModel;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--narration' && i + 1 < args.length) {
      narrationPath = args[++i];
    } else if (arg == '--output-txt' && i + 1 < args.length) {
      outputTxtPath = args[++i];
    } else if (arg == '--output-wav' && i + 1 < args.length) {
      outputWavPath = args[++i];
    } else if (arg == '--lang' && i + 1 < args.length) {
      lang = args[++i];
    } else if (arg == '--piper-model' && i + 1 < args.length) {
      piperModel = args[++i];
    }
  }

  if (narrationPath == null || outputTxtPath == null) {
    stderr.writeln(
      'Usage: dart run bin/align_course_cli.dart --narration <path> --output-txt <path> [--output-wav <path>] [--lang <fr|en>]',
    );
    exit(1);
  }

  final narrationFile = File(narrationPath);
  if (!narrationFile.existsSync()) {
    stderr.writeln('Erreur: Fichier de narration introuvable : $narrationPath');
    exit(1);
  }

  final narrationText = (await narrationFile.readAsString()).trim();
  if (narrationText.isEmpty) {
    stderr.writeln('Erreur: La narration est vide : $narrationPath');
    exit(1);
  }

  final root = Directory.current.path;
  final env = Platform.environment;
  final piperExe =
      env['PIPER_EXE_PATH'] ?? p.join(root, 'speaker', 'piper', 'piper.exe');
  final defaultPiperModel =
      piperModel ??
      (lang == 'en'
          ? p.join(root, 'speaker', 'piper', 'model', 'en_US-lessac-medium.onnx')
          : p.join(root, 'speaker', 'piper', 'model', 'fr_FR-siwis-medium.onnx'));

  if (!File(piperExe).existsSync()) {
    stderr.writeln('Erreur: piper.exe introuvable à : $piperExe');
    exit(1);
  }

  // 1. Détermination du fichier WAV cible
  final tempDir = Directory.systemTemp.createTempSync('illimmi_align_');
  final wavTarget = outputWavPath != null
      ? File(outputWavPath)
      : File(p.join(tempDir.path, 'narration.wav'));
  
  await wavTarget.parent.create(recursive: true);

  // Normalisation du texte : une seule ligne continue pour que Piper synthétise
  // l'intégralité du texte sans écraser le fichier audio à chaque saut de ligne
  final normalizedText = narrationText.split(RegExp(r'\s+')).join(' ');

  // 2. Synthèse Piper TTS
  final piperProcess = await Process.start(piperExe, [
    '-m',
    defaultPiperModel,
    '--output_file',
    wavTarget.path,
  ]);

  piperProcess.stdin.add(utf8.encode(normalizedText));
  await piperProcess.stdin.flush();
  await piperProcess.stdin.close();

  final piperExit = await piperProcess.exitCode;
  if (piperExit != 0) {
    stderr.writeln('Erreur lors de la synthèse vocale Piper (code $piperExit)');
    exit(piperExit);
  }

  // 3. Alignement Whisper.cpp
  final aligner = WhisperCppAligner();
  final words = await aligner.align(
    wavPath: wavTarget.path,
    narrationText: normalizedText,
    language: lang,
  );

  // 4. Écriture du fichier timeline final
  final outputFile = File(outputTxtPath);
  await outputFile.parent.create(recursive: true);
  final writer = const CompactTimelineWriter();
  await writer.writeToFile(outputFile, words);

  // 5. Nettoyage des fichiers temporaires intermédiaires générés par whisper-cli
  final outBase = '${p.withoutExtension(wavTarget.path)}_words';
  final intermediateFiles = [
    File('${p.withoutExtension(wavTarget.path)}_16k.wav'),
    File('$outBase.json'),
    File('$outBase.txt'),
  ];
  for (final f in intermediateFiles) {
    if (f.existsSync() && f.path != outputFile.path) {
      try {
        await f.delete();
      } catch (_) {}
    }
  }

  if (outputWavPath == null) {
    try {
      await tempDir.delete(recursive: true);
    } catch (_) {}
  }

  final duration = words.isNotEmpty ? words.last.end : 0.0;
  final resultJson = jsonEncode({
    'success': true,
    'word_count': words.length,
    'duration_seconds': duration,
    'output_txt': outputFile.path,
    'output_wav': outputWavPath != null ? wavTarget.path : null,
  });

  print(resultJson);
}
