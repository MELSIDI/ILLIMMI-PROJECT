// command_parsers/draw_command_parser.dart
import 'command_parser_interface.dart';
import '../draw_parsers/draw_parser_factory.dart';
import '../draw_parsers/draw_parser_interface.dart';
import '../../models/hyper_element.dart';
//import '../tokenizer/tokenizer.dart';
import '../tokenizer/token_types.dart';

class DrawCommandParser implements CommandParser {
  @override
  bool canParse(String command) => command == 'draw';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    // Chercher le sous-type de draw (line, arrow, circle, etc.)
    int currentIndex = startIndex + 1; // Skip 'draw'
    
    while (currentIndex < tokens.length) {
      Token token = tokens[currentIndex];
      if (token.type == TokenType.IDENTIFIER) {
        DrawParser? parser = DrawParserFactory.getParser(token.value);
        if (parser != null) {
          return parser.parse(tokens, currentIndex);
        }
      }
      currentIndex++;
    }
    
    throw Exception('Type de dessin non reconnu');
  }
}