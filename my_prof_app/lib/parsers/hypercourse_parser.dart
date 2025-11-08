// parsers/hypercourse_parser.dart
import '../models/hyper_element.dart';
import 'tokenizer/tokenizer.dart';
import 'tokenizer/token_types.dart';
import 'command_parsers/command_parser_factory.dart';

class HypercourseParser {
  final String script;

  HypercourseParser(this.script);

  List<HyperElement> parse() {
    final tokenizer = Tokenizer(script);
    final tokens = tokenizer.tokenize();
    
    // Filtrer les tokens inutiles
    final filteredTokens = tokens.where((token) =>
      token.type != TokenType.WHITESPACE && token.type != TokenType.COMMENT
    ).toList();

    return _parseCourse(filteredTokens);
  }

  List<HyperElement> _parseCourse(List<Token> tokens) {
    List<HyperElement> elements = [];
    int currentIndex = 0;

    // Chercher le début du cours
    while (currentIndex < tokens.length) {
      if (tokens[currentIndex].value == 'course') {
        currentIndex = _parseCourseBlock(tokens, currentIndex + 1, elements);
        break;
      }
      currentIndex++;
    }

    print('📋 Elements parsés: ${elements.length}');
    for (var el in elements) {
      print('  - ${el.runtimeType} id=${el.id} start=${el.startTime}s');
    }

    return elements;
  }

  int _parseCourseBlock(List<Token> tokens, int startIndex, List<HyperElement> elements) {
    int currentIndex = startIndex;
    
    // Skip course name and opening brace
    while (currentIndex < tokens.length && tokens[currentIndex].value != '{') {
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
            elements.add(element);
            
            // Avancer jusqu'au prochain point-virgule
            while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
              currentIndex++;
            }
            if (currentIndex < tokens.length && tokens[currentIndex].value == ';') {
              currentIndex++; // Skip ';'
            }
          } catch (e) {
            print('❌ Erreur parsing commande $command: $e');
            throw Exception('Erreur parsing commande $command: $e');
          }
        } else {
          print('⚠️ Commande inconnue: $command');
          // Commande inconnue, avancer jusqu'au prochain ;
          while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
            currentIndex++;
          }
          if (currentIndex < tokens.length) currentIndex++;
        }
      } else {
        currentIndex++;
      }
    }

    return currentIndex + 1; // Skip closing brace
  }
}