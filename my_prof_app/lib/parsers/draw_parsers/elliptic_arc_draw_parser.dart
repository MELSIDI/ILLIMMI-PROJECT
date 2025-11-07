// draw_parsers/elliptic_arc_draw_parser.dart
import 'dart:math' as math;
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/elliptic_arc_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class EllipticArcDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'elliptic_arc';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    String? fillColor;
    double width = 2.5;
    double radiusX = 0;
    double radiusY = 0;
    double rotation = 0;
    Offset center = const Offset(0, 0);
    double startAngle = 0;
    double endAngle = 0;
    bool hasArrowAtEnd = false;
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
      } else if (token.value == 'radiusX') {
        radiusX = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'radiusY') {
        radiusY = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'rotation') {
        rotation = double.parse(tokens[currentIndex + 1].value) * math.pi / 180;
        currentIndex += 2;
      } else if (token.value == 'at') {
        center = ParsingUtils.parsePoint(tokens, currentIndex + 1);
        currentIndex += 4;
      } else if (token.value == 'from') {
        startAngle = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 3; // Skip 'X deg'
      } else if (token.value == 'to') {
        endAngle = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 3; // Skip 'X deg'
      } else if (token.value == 'with') {
        hasArrowAtEnd = true;
        currentIndex++;
        
        // Check for + or - for arrow direction
        if (tokens[currentIndex].value == '+') {
          arrowCounterClockwise = true;
          currentIndex++;
        } else if (tokens[currentIndex].value == '-') {
          arrowCounterClockwise = false;
          currentIndex++;
        }
        
        // Skip 'arrow at end'
        while (currentIndex < tokens.length && 
               tokens[currentIndex].value != ';' &&
               !_isNextCommand(tokens, currentIndex)) {
          currentIndex++;
        }
      } else {
        currentIndex++;
      }
    }
    
    double sweepAngle = (endAngle - startAngle) * math.pi / 180;
    startAngle = startAngle * math.pi / 180;
    
    return EllipticArcElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: ParsingUtils.parseColorString(color),
      width: width,
      center: center,
      radiusX: radiusX,
      radiusY: radiusY,
      rotation: rotation,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      hasArrowAtEnd: hasArrowAtEnd,
      arrowCounterClockwise: arrowCounterClockwise,
      fillColor: ParsingUtils.parseColorString(fillColor),
    );
  }

  bool _isNextCommand(List<Token> tokens, int index) {
    return tokens[index].value == 'start' ||
           tokens[index].value == 'for' ||
           tokens[index].value == 'color' ||
           tokens[index].value == 'width' ||
           tokens[index].value == 'radiusX' ||
           tokens[index].value == 'radiusY' ||
           tokens[index].value == 'rotation' ||
           tokens[index].value == 'at' ||
           tokens[index].value == 'from' ||
           tokens[index].value == 'to';
  }
}