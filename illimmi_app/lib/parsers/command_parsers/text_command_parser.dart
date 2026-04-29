// command_parsers/text_command_parser.dart
import 'command_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/basic_elements/text_element.dart';
//import '../tokenizer/tokenizer.dart';
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class TextCommandParser implements CommandParser {
  @override
  bool canParse(String command) => command == 'text';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    Offset? position;
    double startTime = 0;
    double duration = 0;
    String content = '';
    
    int currentIndex = startIndex + 2; // Skip 'text' and id
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
      Token token = tokens[currentIndex];
      
      if (token.value == 'start') {
        startTime = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'for') {
        duration = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'at') {
        position = ParsingUtils.parsePoint(tokens, currentIndex + 1);
        currentIndex += 4;
      } else if (token.type == TokenType.STRING) {
        content = token.value;
        currentIndex++;
      } else {
        currentIndex++;
      }
    }
    
    return TextElement(
      id: id,
      startTime: startTime,
      duration: duration,
      content: content,
      position: position ?? const Offset(0, 0),
    );
  }
}