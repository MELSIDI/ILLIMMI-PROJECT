// draw_parsers/line_draw_parser.dart
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/line_element.dart';
import '../../models/draw_elements/arrow_element.dart';  
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class LineDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'line' || drawType == 'arrow';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    bool isArrow = tokens[startIndex].value == 'arrow';
    
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    double width = 2.5;
    List<Offset> points = [];
    
    int currentIndex = startIndex + 2; // Skip draw type and id
    
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
        currentIndex += 6; // color ( r , g , b , a )
      } else if (token.value == 'width') {
        width = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'at') {
        points = ParsingUtils.parsePointList(tokens, currentIndex + 1);
        currentIndex += points.length * 3 + 2; // [ (x,y), ... ]
      } else {
        currentIndex++;
      }
    }
    
    if (points.length < 2) {
      throw Exception('Une ligne nécessite au moins 2 points');
    }
    
    if (isArrow) {
      return ArrowElement(
        id: id,
        startTime: startTime,
        duration: duration,
        color: ParsingUtils.parseColorString(color),
        width: width,
        from: points[0],
        to: points[1],
      );
    } else {
      return LineElement(
        id: id,
        startTime: startTime,
        duration: duration,
        color: ParsingUtils.parseColorString(color),
        width: width,
        from: points[0],
        to: points[1],
      );
    }
  }
}