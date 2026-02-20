import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart'
    as p; // Utilise le package 'path' pour la propreté
import 'package:audioplayers/audioplayers.dart';

class TtsResults {
  File? file;
  double duration;
  TtsResults({this.file, this.duration = -1});
}

class PiperServices {
  late final String piperPath;
  late final String modelPath;
  late final String outputDir;

  PiperServices() {
    // Directory.current.path est la racine de ton projet en mode débug
    final root = Directory.current.path;

    // On construit les chemins proprement sans ../../../
    piperPath = p.join(root, 'speaker', 'piper', 'piper.exe');
    modelPath = p.join(
      root,
      'speaker',
      'piper',
      'model',
      'fr_FR-siwis-medium.onnx',
    );
    outputDir = p.join(root, 'speaker', 'audios');
    // Créer le dossier parent 'audios' s'il n'existe pas encore
    Directory(outputDir).createSync(recursive: true);
  }

  Future<TtsResults?> tts({
    required String text,
    required String dirName,
    required String fileName,
  }) async {
    // Vérification de l'existence de piper.exe avant de lancer
    if (!File(piperPath).existsSync()) {
      print("❌ ERREUR : Exécutable introuvable à : $piperPath");
      return null;
    }

    final fullDirectoryPath = p.join(outputDir, dirName);
    final fullFilePath = p.join(fullDirectoryPath, '$fileName.wav');

    // OPTIMISATION : Si l'audio existe déjà, on le retourne direct !
    final file = File(fullFilePath);
    if (await file.exists()) {
      // On utilise un lecteur temporaire pour obtenir la durée précise
      final tempPlayer = AudioPlayer();
      await tempPlayer.setSourceDeviceFile(file.path);
      final duration = await tempPlayer.getDuration();
      await tempPlayer.dispose();
      return TtsResults(
        file: file,
        duration: (duration!.inMilliseconds / 1000),
      );
    }

    // Création du dossier si besoin
    await Directory(fullDirectoryPath).create(recursive: true);

    try {
      final process = await Process.start(piperPath, [
        '-m',
        modelPath,
        '--output_file',
        fullFilePath,
      ]);

      double? extractedDuration;

      //On écoute les logs de Piper (stderr) en temps réel
      process.stderr.transform(utf8.decoder).listen((line) {
        // On cherche la chaîne "audio=X sec" dans les logs de piper
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
        return TtsResults(
          file: File(fullFilePath),
          duration: extractedDuration!,
        );
      }
    } catch (e) {
      print("❌ Erreur lors du lancement du processus : $e");
    }
    return null;
  }
}
