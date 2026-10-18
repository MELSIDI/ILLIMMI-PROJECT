// parsers/hypercourse_parser.dart
import 'package:illimmi_app/models/basic_elements/erase_element.dart';
import 'package:illimmi_app/models/basic_elements/text_element.dart';
import 'package:illimmi_app/models/hyper_element.dart';
import 'package:illimmi_app/parsers/parsing_utils.dart';

//import '../models/hyper_element.dart';
import 'tokenizer/tokenizer.dart';
import 'tokenizer/token_types.dart';
import 'command_parsers/command_parser_factory.dart';
import '../models/course.dart';
import '../models/id_config.dart';

class HypercourseParser {
  final String script;
  int currentIndex = 0;

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
    String? audioPath;
    Map<int, HyperElement> elements = {};
    double Maxduration = 0;

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
      } else if (tokens[currentIndex].value == 'audio') {
        // Nouveau format ILLIMMI : audio externe unique, déclaré dans le header.
        audioPath = ParsingUtils.parseAudioPath(tokens, currentIndex);
        currentIndex++; // consomme le token STRING (nom de fichier) pour qu'il ne soit pas
        // revisité au tour suivant et pris à tort pour le courseName (cf. branche STRING ci-dessus).
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
              if (element.idsToErase.isEmpty) {
                // Effacement global du tableau : tous les éléments visuels précédents se terminent ici
                for (final prev in elements.values) {
                  if (prev is! EraseElement && prev.startTime <= element.startTime && prev.endTime > element.startTime) {
                    prev.endTime = element.startTime;
                  }
                }
              } else {
                for (int targetId in element.idsToErase) {
                  elements[targetId]?.endTime = element
                      .startTime; // On ferme la fenêtre de vie de l'élément ciblé
                }
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

    currentIndex++; // Skip closing brace

    // Calcul de la durée : chaque élément a un timing fixe fourni par l'auteur du script,
    // il n'y a plus de synchronisation/décalage basé sur une synthèse audio quelconque.
    duration = Maxduration > duration ? Maxduration + 60 : duration + 60;

    print('🛠 Création du cours: $courseName avec duration: $duration');
    Course course = Course(
      courseName,
      IdConfig(id: id, idGap: idGap, duration: duration, audioPath: audioPath),
    );
    for (var element in elements.values) {
      course.insert(element);
    }
    return course;
  }
}
