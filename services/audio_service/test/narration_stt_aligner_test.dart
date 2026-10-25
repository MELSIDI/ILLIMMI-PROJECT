import 'dart:io';

import 'package:audio_service/align/compact_timeline.dart';
import 'package:audio_service/align/narration_parser.dart';
import 'package:audio_service/align/narration_stt_aligner.dart';
import 'package:audio_service/align/stt_parser.dart';
import 'package:audio_service/models.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('NarrationParser', () {
    final parser = NarrationParser();

    test('rattache la ponctuation double française (point d\'exclamation, deux-points)', () {
      const text = 'Bonjour ! Voici trois points : E, F, et G.';
      final words = parser.parse(text);

      expect(words.map((w) => w.text).toList(), [
        'Bonjour !',
        'Voici',
        'trois',
        'points :',
        'E,',
        'F,',
        'et',
        'G.',
      ]);
      expect(words[0].cleanWord, 'Bonjour');
      expect(words[0].matchKey, 'bonjour');
      expect(words[3].cleanWord, 'points');
      expect(words[3].matchKey, 'points');
    });

    test('gère correctement les apostrophes et élisions françaises', () {
      const text = "à partir d'égalités vectorielles c'est-à-dire qu'ils aient";
      final words = parser.parse(text);

      expect(words[2].text, "d'égalités");
      expect(words[2].cleanWord, "d'égalités");
      expect(words[4].text, "c'est-à-dire");
      expect(words[5].text, "qu'ils");
    });
  });

  group('SttParser', () {
    final parser = SttParser();

    test('parse et convertit les millisecondes en secondes', () {
      final rawTokens = [
        {
          'text': '',
          'offsets': {'from': 0, 'to': 100},
        },
        {
          'text': ' Bonjour',
          'offsets': {'from': 110, 'to': 620},
        },
        {
          'text': '.',
          'offsets': {'from': 620, 'to': 1300},
        },
      ];

      final tokens = parser.parseTokens(rawTokens);
      expect(tokens.length, 2); // Le token vide est ignoré
      expect(tokens[0].trimmed, 'Bonjour');
      expect(tokens[0].start, 0.110);
      expect(tokens[0].end, 0.620);
      expect(tokens[0].isPunctuation, isFalse);

      expect(tokens[1].trimmed, '.');
      expect(tokens[1].start, 0.620);
      expect(tokens[1].end, 1.300);
      expect(tokens[1].isPunctuation, isTrue);
    });
  });

  group('CompactTimelineWriter & CompactTimelineReader', () {
    const writer = CompactTimelineWriter();
    const reader = CompactTimelineReader();

    test('sérialise et désérialise le format compact <start>mot<end>', () {
      final words = [
        WordTimestamp(word: 'Bonjour !', start: 0.110, end: 1.300),
        WordTimestamp(word: 'Dans', start: 1.300, end: 1.380),
        WordTimestamp(word: 'construire', start: 3.160, end: 3.600),
      ];

      final compactText = writer.writeToString(words);
      expect(compactText, contains('<0.110>Bonjour !<1.300>'));
      expect(compactText, contains('<1.300>Dans<1.380>'));
      expect(compactText, contains('<3.160>construire<3.600>'));

      final parsed = reader.readFromString(compactText);
      expect(parsed.length, 3);
      expect(parsed[0].word, 'Bonjour !');
      expect(parsed[0].start, 0.110);
      expect(parsed[0].end, 1.300);
      expect(parsed[0].cleanWord, 'Bonjour');

      expect(parsed[2].word, 'construire');
      expect(parsed[2].start, 3.160);
      expect(parsed[2].end, 3.600);
    });
  });

  group('NarrationSttAligner', () {
    final narrationParser = NarrationParser();
    final sttParser = SttParser();
    final aligner = NarrationSttAligner();

    test('fusionne les fragments STT sous-mots (ex. "constru" + "ire" -> "construire")', () {
      final narrationWords = narrationParser.parse('construire des points');
      final rawTokens = [
        {
          'text': ' constru',
          'offsets': {'from': 3160, 'to': 3530},
        },
        {
          'text': 'ire',
          'offsets': {'from': 3530, 'to': 3600},
        },
        {
          'text': ' des',
          'offsets': {'from': 3600, 'to': 3840},
        },
        {
          'text': ' points',
          'offsets': {'from': 3840, 'to': 4180},
        },
      ];

      final sttTokens = sttParser.parseTokens(rawTokens);
      final aligned = aligner.align(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
      );

      expect(aligned.length, 3);
      expect(aligned[0].word, 'construire');
      expect(aligned[0].start, 3.160);
      expect(aligned[0].end, 3.600);
      expect(aligned[0].confidence, 'MERGED');

      expect(aligned[1].word, 'des');
      expect(aligned[1].start, 3.600);
      expect(aligned[1].end, 3.840);

      expect(aligned[2].word, 'points');
      expect(aligned[2].start, 3.840);
      expect(aligned[2].end, 4.180);
    });

    test('priorité textuelle : utilise la ponctuation de narration.txt et absorbe la pause finale', () {
      final narrationWords = narrationParser.parse('Bonjour ! Dans ce cours,');
      final rawTokens = [
        {
          'text': ' Bonjour',
          'offsets': {'from': 110, 'to': 620},
        },
        {
          'text': '.', // Whisper a produit "." au lieu de "!"
          'offsets': {'from': 620, 'to': 1300},
        },
        {
          'text': ' Dans',
          'offsets': {'from': 1300, 'to': 1380},
        },
        {
          'text': ' ce',
          'offsets': {'from': 1380, 'to': 1450},
        },
        {
          'text': ' cours',
          'offsets': {'from': 1450, 'to': 1830},
        },
        {
          'text': ',',
          'offsets': {'from': 1830, 'to': 2150},
        },
      ];

      final sttTokens = sttParser.parseTokens(rawTokens);
      final aligned = aligner.align(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
      );

      expect(aligned[0].word, 'Bonjour !'); // Ponctuation vient de narration.txt !
      expect(aligned[0].start, 0.110);
      expect(aligned[0].end, 1.300); // Absorbe la pause de fin de phrase

      expect(aligned[1].word, 'Dans');
      expect(aligned[1].start, 1.300);
      expect(aligned[1].end, 1.380);

      expect(aligned[3].word, 'cours,');
      expect(aligned[3].start, 1.450);
      expect(aligned[3].end, 1.830);
    });

    test('découpe un token STT combiné en plusieurs mots de narration ("AB" -> "A" et "B")', () {
      final narrationWords = narrationParser.parse('le vecteur A B est égal');
      final rawTokens = [
        {
          'text': ' le',
          'offsets': {'from': 44490, 'to': 44490},
        },
        {
          'text': ' ve',
          'offsets': {'from': 44490, 'to': 44600},
        },
        {
          'text': 'ct',
          'offsets': {'from': 44600, 'to': 44710},
        },
        {
          'text': 'eur',
          'offsets': {'from': 44710, 'to': 44980},
        },
        {
          'text': ' AB', // Whisper a combiné A et B
          'offsets': {'from': 44980, 'to': 45100},
        },
        {
          'text': ' est',
          'offsets': {'from': 45100, 'to': 45140},
        },
        {
          'text': ' égal',
          'offsets': {'from': 45140, 'to': 45460},
        },
      ];

      final sttTokens = sttParser.parseTokens(rawTokens);
      final aligned = aligner.align(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
      );

      expect(aligned.length, 6);
      expect(aligned[0].word, 'le');
      expect(aligned[1].word, 'vecteur');
      expect(aligned[2].word, 'A');
      expect(aligned[2].start, 44.980);
      expect(aligned[2].end, 45.040);
      expect(aligned[2].confidence, 'SPLIT_FROM_STT');

      expect(aligned[3].word, 'B');
      expect(aligned[3].start, 45.040);
      expect(aligned[3].end, 45.100);
      expect(aligned[3].confidence, 'SPLIT_FROM_STT');

      expect(aligned[4].word, 'est');
      expect(aligned[5].word, 'égal');
    });

    test('reconnaît les nombres prononcés (ex. "trois" <-> "3")', () {
      final narrationWords = narrationParser.parse('nos trois points');
      final rawTokens = [
        {
          'text': ' nos',
          'offsets': {'from': 164650, 'to': 165190},
        },
        {
          'text': ' 3', // Whisper a transcrit un chiffre au lieu de lettres
          'offsets': {'from': 165190, 'to': 165320},
        },
        {
          'text': ' points',
          'offsets': {'from': 165320, 'to': 165560},
        },
      ];

      final sttTokens = sttParser.parseTokens(rawTokens);
      final aligned = aligner.align(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
      );

      expect(aligned.length, 3);
      expect(aligned[1].word, 'trois');
      expect(aligned[1].start, 165.190);
      expect(aligned[1].end, 165.320);
    });

    test('gère les timestamps identiques avec start <= end', () {
      final narrationWords = narrationParser.parse('tu vas');
      final rawTokens = [
        {
          'text': ' tu',
          'offsets': {'from': 2150, 'to': 2150},
        },
        {
          'text': ' vas',
          'offsets': {'from': 2150, 'to': 2610},
        },
      ];

      final sttTokens = sttParser.parseTokens(rawTokens);
      final aligned = aligner.align(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
      );

      expect(aligned[0].start, 2.150);
      expect(aligned[0].end, 2.150);
      expect(aligned[0].start <= aligned[0].end, isTrue);

      expect(aligned[1].start, 2.150);
      expect(aligned[1].end, 2.610);
      expect(aligned[0].end <= aligned[1].start, isTrue);
    });

    test('validation complète de référence sur le cours vecteurs (532 mots, 0 perte, ordre conservé)', () async {
      final dir = Directory('speaker/audios/vecteurs');
      final narrationFile = File(p.join(dir.path, 'narration.txt'));
      final jsonFile = File(p.join(dir.path, 'vecteurs_words.json'));

      expect(narrationFile.existsSync(), isTrue);
      expect(jsonFile.existsSync(), isTrue);

      final narrationText = await narrationFile.readAsString();
      final narrationWords = narrationParser.parse(narrationText);
      final sttTokens = await sttParser.parseJsonFile(jsonFile);

      final aligned = aligner.align(
        narrationWords: narrationWords,
        sttTokens: sttTokens,
      );

      // Critère 1 : Nombre de mots exact (aucune perte silencieuse)
      expect(aligned.length, narrationWords.length);
      expect(aligned.length, 532);

      // Critère 2 : La séquence textuelle finale correspond exactement à narration.txt
      for (var i = 0; i < aligned.length; i++) {
        expect(aligned[i].word, narrationWords[i].text);
      }

      // Critère 3 : Ponctuation finale provient de narration.txt
      expect(aligned[0].word, 'Bonjour !');
      expect(aligned[0].start, 0.110);
      expect(aligned[0].end, 1.300);

      // Critère 4 : constru + ire -> construire avec timestamps exacts
      final construireWord = aligned.firstWhere((w) => w.word == 'construire');
      expect(construireWord.start, 3.160);
      expect(construireWord.end, 3.600);

      // Critère 5 : Monotonie stricte
      for (var i = 0; i < aligned.length; i++) {
        expect(aligned[i].start <= aligned[i].end, isTrue);
        if (i > 0) {
          expect(aligned[i].start >= aligned[i - 1].start, isTrue);
        }
      }

      // Critère 6 : Fichiers compacts générés
      final compactFile = File(p.join(dir.path, 'vecteur_words.txt'));
      expect(compactFile.existsSync(), isTrue);
      final readBack = await const CompactTimelineReader().readFromFile(compactFile);
      expect(readBack.length, 532);
      expect(readBack[0].word, 'Bonjour !');
      expect(readBack[0].start, 0.110);
      expect(readBack[0].end, 1.300);
    });

    test('résilience aux désynchronisations et acronymes (resynchronisation sans blocage temporel)', () async {
      final dir = Directory('speaker/audios/expliquer_moi_comment_le_triggers_en_fonction_dans_pl_sql');
      final narrationFile = File(p.join(dir.path, 'narration.txt'));
      final jsonFile = File(p.join(dir.path, 'narration_words.json'));

      if (narrationFile.existsSync() && jsonFile.existsSync()) {
        final narrationText = await narrationFile.readAsString();
        final narrationWords = narrationParser.parse(narrationText);
        final sttTokens = await sttParser.parseJsonFile(jsonFile);

        final aligned = aligner.align(
          narrationWords: narrationWords,
          sttTokens: sttTokens,
        );

        expect(aligned.length, narrationWords.length);
        expect(aligned.length, 820);

        // Vérifie qu'aucun blocage à 19.270 ne persiste sur l'ensemble du cours
        int lockedAt19 = 0;
        for (final w in aligned) {
          if ((w.start - 19.270).abs() < 0.001) lockedAt19++;
        }
        expect(lockedAt19 <= 1, isTrue); // Au plus 1 seul mot à ce timestamp exact, pas des centaines

        // Vérifie que le dernier mot atteint bien la fin de l'audio (> 250s)
        expect(aligned.last.end > 250.0, isTrue);
      }
    });
  });
}
