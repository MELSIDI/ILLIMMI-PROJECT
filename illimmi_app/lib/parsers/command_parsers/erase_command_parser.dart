// command_parsers/erase_command_parser.dart
import 'command_parser_interface.dart';
import '../../models/basic_elements/erase_element.dart'; 
import '../../models/hyper_element.dart';
//import '../tokenizer/tokenizer.dart';
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';

class EraseCommandParser implements CommandParser {
  @override
  bool canParse(String command) => command == 'erase';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    List<int> idsToErase = [];
    
    int currentIndex = startIndex + 2;
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
      Token token = tokens[currentIndex];
      
      if (token.value == 'start') {
        startTime = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'for') {
        duration = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'at') {
        idsToErase = _parseIdList(tokens, currentIndex + 1);
        currentIndex += idsToErase.length * 2 + 2; // [id1, id2, ...]
      } else {
        currentIndex++;
      }
    }
    
    return EraseElement(
      id: id,
      startTime: startTime,
      duration: duration,
      idsToErase: idsToErase,
    );
  }

  List<int> _parseIdList(List<Token> tokens, int startIndex) {
    List<int> ids = [];
    int currentIndex = startIndex;
    
    if (tokens[currentIndex].value != '[') {
      throw Exception('Liste d\'IDs attendue');
    }
    currentIndex++;
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ']') {
      if (tokens[currentIndex].type == TokenType.NUMBER) {
        ids.add(int.parse(tokens[currentIndex].value));
        currentIndex++;
      } else if (tokens[currentIndex].value == ',') {
        currentIndex++;
      } else {
        currentIndex++;
      }
    }
    
    return ids;
  }
}