// parsers/hypercourse_parser.dart
import 'dart:io';

import 'package:illimmi_app/models/basic_elements/erase_element.dart';
import 'package:illimmi_app/models/basic_elements/speech_element.dart';
import 'package:illimmi_app/models/basic_elements/text_element.dart';
import 'package:illimmi_app/models/hyper_element.dart';
import 'package:illimmi_app/parsers/parsing_utils.dart';
import 'package:illimmi_app/speech_manager/piper_servicices.dart';

//import '../models/hyper_element.dart';
import 'tokenizer/tokenizer.dart';
import 'tokenizer/token_types.dart';
import 'command_parsers/command_parser_factory.dart';
import '../models/course.dart';
import '../models/id_config.dart';

class HypercourseParser {
  final String script;
  int currentIndex = 0;
  final PiperServices _tts = PiperServices();

  HypercourseParser(this.script);

  Future<Course> parse() async {
    final tokenizer = Tokenizer(script);
    final tokens = tokenizer.tokenize();

    // Filtrer les tokens inutiles
    final filteredTokens = tokens
        .where(
          (token) =>
              token.type != TokenType.WHITESPACE &&
              token.type != TokenType.COMMENT,
        )
        .toList();

    return await _parseCourse(filteredTokens);
  }

  Future<Course> _parseCourse(List<Token> tokens) async {
    Course? course;

    // Chercher le début du cours
    while (currentIndex < tokens.length) {
      if (tokens[currentIndex].value == 'course') {
        currentIndex++; // Skip 'course'
        course = await _parseCourseBlock(tokens);
        break;
      }
      currentIndex++;
    }

    /*print('📋 Elements parsés: ${elements.length}');
    for (var el in elements) {
      print('  - ${el.runtimeType} id=${el.id} start=${el.startTime}s');
    }*/

    return course ?? (throw Exception('Bloc course non trouvé'));
  }

  Future<Course> _parseCourseBlock(List<Token> tokens) async {
    String courseName = 'Unnamed Course';
    int id = 1;
    int idGap = 10000;
    double duration = 3600;
    Map<int, HyperElement> elements = {};
    double Maxduration = 0;
    PiperServices tts = PiperServices();

    while (currentIndex < tokens.length && tokens[currentIndex].value != '{') {
      // on recupere le nom du cours, son id, son idGap et sa durée specipier par l'IA
      if (tokens[currentIndex].type == TokenType.STRING) {
        courseName = tokens[currentIndex].value;
      } else if (tokens[currentIndex].value == 'id') {
        id = ParsingUtils.parseId(tokens, currentIndex);
      } else if (tokens[currentIndex].value == 'idgap') {
        idGap = ParsingUtils.parseId(tokens, currentIndex);
      } else if (tokens[currentIndex].value == 'for') {
        duration = ParsingUtils.parseTime(tokens, currentIndex);
      }
      currentIndex++;
    }

    if (currentIndex >= tokens.length || tokens[currentIndex].value != '{') {
      throw Exception('Accolade ouvrante attendue');
    }
    currentIndex++;

    // Parse commands until closing brace
    while (currentIndex < tokens.length && tokens[currentIndex].value != '}') {
      if (tokens[currentIndex].type == TokenType.IDENTIFIER) {
        final command = tokens[currentIndex].value;
        final parser = CommandParserFactory.getParser(command);

        if (parser != null) {
          try {
            print('🔍 Parsing commande: $command à index $currentIndex');
            final element = parser.parse(tokens, currentIndex);
            print(
              '✅ Commande parsée: ${element.runtimeType} id=${element.id} start=${element.startTime}s end=${element.endTime}s content=${element is TextElement ? element.content : 'N/A'}',
            );
            if (element is EraseElement) {
              for (int targetId in element.idsToErase) {
                elements[targetId]?.endTime = element
                    .startTime; // On ferme la fenêtre de vie de l'élément ciblé
              }
            }
            if (element.startTime + element.duration > Maxduration) {
              Maxduration = element.startTime + element.duration;
            }
            elements[element.id] =
                element; // Stockage dans le registre local du parser
            print('📊 Éléments dans le cours: ${elements.length}');

            // Avancer jusqu'au prochain point-virgule
            while (currentIndex < tokens.length &&
                tokens[currentIndex].value != ';') {
              currentIndex++;
            }
            if (currentIndex < tokens.length &&
                tokens[currentIndex].value == ';') {
              currentIndex++; // Skip ';'
            }
          } catch (e) {
            print('❌ Erreur parsing commande $command: $e');
            throw Exception('Erreur parsing commande $command: $e');
          }
        } else {
          print('⚠️ Commande inconnue: $command');
          // Commande inconnue, avancer jusqu'au prochain ;
          while (currentIndex < tokens.length &&
              tokens[currentIndex].value != ';') {
            currentIndex++;
          }
          if (currentIndex < tokens.length) currentIndex++;
        }
      } else {
        currentIndex++;
      }
    }

    /*currentIndex++; // Skip closing brace
    // Insérer tous les éléments parsés dans le cours
    duration = Maxduration > duration ? Maxduration + 60 : duration + 60; // Ajuster la durée du cours si nécessaire
    Course course = Course(courseName, IdConfig(id: id, idGap: idGap, duration: duration));
    for (var element in elements.values) {
      course.insert(element);
    }
    return course;*/

    currentIndex++; // Skip closing brace

    // Calcul de la durée
    duration = Maxduration > duration ? Maxduration + 60 : duration + 60;

    // Avant d'insérer les éléments dans le cours, on applique les corrections temporelles pour éviter les chevauchements
    try {
      double? realDuration = await _applyTemporalCorrections(
        elements,
        courseName,
        id,
      );
      duration = realDuration! > duration ? realDuration + 60 : duration;
      print('🛠 Création du cours: $courseName avec duration: $duration');
      Course course = Course(
        courseName,
        IdConfig(id: id, idGap: idGap, duration: duration),
      );
      for (var element in elements.values) {
        try {
          // L'INSERTION DOIT TOUJOURS ÊTRE APRÈS LA SYNTHÈSE
          // Pour que l'arbre de segments connaisse la vraie durée
          // Et ici c'est le cas car on insère les éléments APRÈS avoir appliqué
          //les corrections temporelles basées sur les durées réelles des éléments de type SpeechElement
          course.insert(element);
        } catch (e, stack) {
          print('❌ LE CRASH EST ICI: $e');
          print('STACKTRACE: $stack');
          rethrow;
        }
      }
      return course;
    } catch (e) {
      print('❌ Erreur lors de l\'application des corrections temporelles: $e');
      throw Exception(
        'Erreur lors de l\'application des corrections temporelles: $e',
      );
    }
  }

  Future<double?> _applyTemporalCorrections(
    Map<int, HyperElement> elements,
    String courseName,
    int courseId,
  ) async {
    double cumulativeOffset = 0.0;
    double lastAudioEnd = 0.0;
    double realDuration =
        0.0; // Durée reele du cours, à calculer en fonction des éléments et de leurs durées réelles après synthèse
    const double safetyBuffer = 0.5;

    // On trie les éléments par ordre de début pour appliquer les corrections dans le bon ordre
    var sortedElements = elements.values.toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    for (var element in sortedElements) {
      // 1. On applique le retard accumulé à tout le monde
      element.startTime += cumulativeOffset;
      element.endTime += cumulativeOffset;

      if (element is SpeechElement) {
        // 2. Si collision avec l'audio précédent, on décale et on augmente le retard
        if (element.startTime < lastAudioEnd) {
          double shift = lastAudioEnd - element.startTime;
          element.startTime += shift;
          element.endTime += shift;
          cumulativeOffset += shift;
        }

        // 3. On stocke le moment PRÉCIS où cet audio commence
        double currentSpeechStart = element.startTime;

        // Synthèse Piper
        final result = await _tts.tts(
          text: element.text,
          dirName: '${courseName}_$courseId',
          fileName: 'Speech${element.id}',
        );

        if (result != null) {
          element.audioPath = result.file!.path;
          element.duration = result.duration;
          element.endTime = element.startTime + result.duration;

          lastAudioEnd = element.endTime + safetyBuffer;
          realDuration = element.endTime > realDuration
              ? element.endTime
              : realDuration;

          // 4. Correction des éléments statiques PRÉCÉDENTS
          // On repasse sur les éléments pour étirer ceux qui chevauchent ce speech
          for (var other in elements.values) {
            if (other is! SpeechElement && other is! EraseElement) {
              // SI l'élément finit APRÈS le début de l'audio actuel
              // ET qu'il finit AVANT la fin de l'audio actuel
              if (other.endTime > currentSpeechStart &&
                  other.endTime < element.endTime) {
                other.endTime = element.endTime;
              }
            }
          }
        } else {
          print(
            '❌ ERREUR TTS pour SpeechElement ID: ${element.id} avec texte: "${element.text}"',
          );
          throw Exception(
            'Erreur TTS pour SpeechElement ID: ${element.id} avec texte: "${element.text}"',
          );
        }
      }
    }
    return realDuration;
  }
}
