// command_parsers/mouse_command_parser.dart
import 'command_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/basic_elements/mouse_event_element.dart';
//import '../tokenizer/tokenizer.dart';
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class MouseCommandParser implements CommandParser {
  @override
  bool canParse(String command) => command == 'mouse';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    // Check for 'move' after 'mouse'
    if (tokens[startIndex + 1].value != 'move') {
      throw Exception('Commande mouse non supportée');
    }
    
    int id = ParsingUtils.parseId(tokens, startIndex + 2);
    double startTime = 0;
    double duration = 0;
    List<Offset> points = [];
    
    int currentIndex = startIndex + 3;
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
      Token token = tokens[currentIndex];
      
      if (token.value == 'start') {
        startTime = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'for') {
        duration = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'at') {
        points = ParsingUtils.parsePointList(tokens, currentIndex + 1);
        currentIndex += points.length * 3 + 2;
      } else {
        currentIndex++;
      }
    }
    
    return MouseEvent(
      id: id,
      startTime: startTime,
      duration: duration,
      points: points,
    );
  }
}