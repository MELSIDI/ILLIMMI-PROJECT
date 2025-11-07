// draw_parsers/path_draw_parser.dart
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/path_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart'; 

class PathDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'path';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    double width = 2.5;
    List<Offset> points = [];
    
    int currentIndex = startIndex + 2;
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
      Token token = tokens[currentIndex];
      
      if (token.value == 'start') {
        startTime = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'for') {
        duration = ParsingUtils.parseTime(tokens, currentIndex);
        currentIndex += 2;
      } else if (token.value == 'color') {
        color = ParsingUtils.parseColor(tokens, currentIndex);
        currentIndex += 6;
      } else if (token.value == 'width') {
        width = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'at') {
        points = ParsingUtils.parsePointList(tokens, currentIndex + 1);
        currentIndex += points.length * 3 + 2;
      } else {
        currentIndex++;
      }
    }
    
    return PathElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: ParsingUtils.parseColorString(color),
      width: width,
      points: points,
    );
  }
}