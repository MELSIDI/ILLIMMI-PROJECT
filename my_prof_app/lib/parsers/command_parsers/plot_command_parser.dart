// command_parsers/plot_command_parser.dart
import 'command_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/basic_elements/plot_element.dart'; 
//import '../tokenizer/tokenizer.dart';
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class PlotCommandParser implements CommandParser {
  @override
  bool canParse(String command) => command == 'plot';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    Offset position = const Offset(0, 0);
    String code = '';
    
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
        position = ParsingUtils.parsePoint(tokens, currentIndex + 1);
        currentIndex += 4;
      } else if (token.value == 'code') {
        // Skip 'python' and get the string
        if (currentIndex + 2 < tokens.length && tokens[currentIndex + 1].value == 'python') {
          code = tokens[currentIndex + 2].value;
          currentIndex += 3;
        }
      } else {
        currentIndex++;
      }
    }
    
    return PlotElement(
      id: id,
      startTime: startTime,
      duration: duration,
      position: position,
      code: code,
    );
  }
}