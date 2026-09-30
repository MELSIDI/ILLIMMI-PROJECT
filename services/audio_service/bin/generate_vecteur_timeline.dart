import 'dart:io';

import 'package:path/path.dart' as p;
import '../lib/align/compact_timeline.dart';
import '../lib/align/narration_parser.dart';
import '../lib/align/narration_stt_aligner.dart';
import '../lib/align/stt_parser.dart';

Future<void> main() async {
  final dir = Directory('speaker/audios/vecteurs');
  final narrationFile = File(p.join(dir.path, 'narration.txt'));
  final jsonFile = File(p.join(dir.path, 'vecteurs_words.json'));

  if (!narrationFile.existsSync() || !jsonFile.existsSync()) {
    print('Fichiers sources introuvables.');
    exit(1);
  }

  print('1. Lecture et tokenisation de narration.txt...');
  final narrationText = await narrationFile.readAsString();
  final narrationWords = NarrationParser().parse(narrationText);
  print('   ${narrationWords.length} mots extraits de narration.txt');

  print('2. Lecture et parsing des tokens STT...');
  final sttTokens = await SttParser().parseJsonFile(jsonFile);
  print('   ${sttTokens.length} tokens STT extraits');

  print('3. Alignement déterministe Narration (texte) <-> STT (temps)...');
  final alignedWords = NarrationSttAligner().align(
    narrationWords: narrationWords,
    sttTokens: sttTokens,
  );
  print('   ${alignedWords.length} mots alignés.');

  print('4. Écriture des fichiers compacts vecteur_words.txt et vecteurs_words.txt...');
  final writer = const CompactTimelineWriter();
  final targetFile1 = File(p.join(dir.path, 'vecteur_words.txt'));
  final targetFile2 = File(p.join(dir.path, 'vecteurs_words.txt'));

  await writer.writeToFile(targetFile1, alignedWords);
  await writer.writeToFile(targetFile2, alignedWords);

  print('   Fichiers écrits avec succès :');
  print('   - ${targetFile1.path} (${targetFile1.lengthSync()} octets)');
  print('   - ${targetFile2.path} (${targetFile2.lengthSync()} octets)');

  // Print first 15 lines
  print('\nExtrait des 15 premières lignes :');
  final lines = (await targetFile1.readAsString()).split('\n').take(15);
  for (final l in lines) {
    print('   $l');
  }
}
