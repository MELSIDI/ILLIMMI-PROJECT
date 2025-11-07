// command_parsers/speech_command_parser.dart
import 'command_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/basic_elements/speech_element.dart'; 
//import '../tokenizer/tokenizer.dart';
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';

class SpeechCommandParser implements CommandParser {
  @override
  bool canParse(String command) => command == 'speech';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String text = '';
    
    int currentIndex = startIndex + 2;
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
      Token token = tokens[currentIndex];
      
      if (token.value == 'start') {
        startTime = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'for') {
        duration = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.type == TokenType.STRING) {
        text = token.value;
        currentIndex++;
      } else {
        currentIndex++;
      }
    }
    
    return SpeechElement(
      id: id,
      startTime: startTime,
      duration: duration,
      text: text,
    );
  }
}