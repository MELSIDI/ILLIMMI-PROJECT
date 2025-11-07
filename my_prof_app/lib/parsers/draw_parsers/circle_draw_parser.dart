// draw_parsers/circle_draw_parser.dart
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/circle_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class CircleDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'circle';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    String? fillColor;
    double width = 2.5;
    double radius = 0;
    Offset center = const Offset(0, 0);
    double? arrowAngle;
    bool? arrowCounterClockwise;
    
    int currentIndex = startIndex + 2;
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
      Token token = tokens[currentIndex];
      
      if (token.value == 'start') {
        startTime = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'for') {
        duration = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'fillcolor') {
        fillColor = ParsingUtils.parseColor(tokens, currentIndex);
        currentIndex += 6;
      } else if (token.value == 'color') {
        color = ParsingUtils.parseColor(tokens, currentIndex);
        currentIndex += 6;
      } else if (token.value == 'width') {
        width = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'radius') {
        radius = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'at') {
        center = ParsingUtils.parsePoint(tokens, currentIndex + 1);
        currentIndex += 4;
      } else if (token.value == 'with') {
        currentIndex++;
        
        // Check for + or - for arrow direction
        if (tokens[currentIndex].value == '+') {
          arrowCounterClockwise = true;
          currentIndex++;
        } else if (tokens[currentIndex].value == '-') {
          arrowCounterClockwise = false;
          currentIndex++;
        }
        
        // Skip 'arrow on X deg'
        while (currentIndex < tokens.length && 
               tokens[currentIndex].value != ';' &&
               !_isNextCommand(tokens, currentIndex)) {
          if (tokens[currentIndex].type == TokenType.NUMBER) {
            arrowAngle = double.parse(tokens[currentIndex].value);
          }
          currentIndex++;
        }
      } else {
        currentIndex++;
      }
    }
    
    return CircleElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: ParsingUtils.parseColorString(color),
      width: width,
      center: center,
      radius: radius,
      fillColor: ParsingUtils.parseColorString(fillColor),
      arrowAngle: arrowAngle,
      arrowCounterClockwise: arrowCounterClockwise,
    );
  }

  bool _isNextCommand(List<Token> tokens, int index) {
    return tokens[index].value == 'start' ||
           tokens[index].value == 'for' ||
           tokens[index].value == 'color' ||
           tokens[index].value == 'width' ||
           tokens[index].value == 'radius' ||
           tokens[index].value == 'at';
  }
}