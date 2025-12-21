// draw_parsers/arc_draw_parser.dart
import 'dart:math' as math;
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/arc_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class ArcDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'arc';

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
      } else if (token.value == 'radius') {
        radius = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'at') {
        center = ParsingUtils.parsePoint(tokens, currentIndex + 1);
        currentIndex += 4;
      } else if (token.value == 'from') {
        // Parse angle value (peut être "0deg" ou "0" + "deg")
        String angleStr = tokens[currentIndex + 1].value;
        startAngle = _parseAngleValue(angleStr);
        currentIndex += 2; // Skip 'from' + angle
        // Skip 'deg' si c'est un token séparé
        if (currentIndex < tokens.length && tokens[currentIndex].value == 'deg') {
          currentIndex++;
        }
      } else if (token.value == 'to') {
        // Parse angle value (peut être "180deg" ou "180" + "deg")
        String angleStr = tokens[currentIndex + 1].value;
        endAngle = _parseAngleValue(angleStr);
        currentIndex += 2; // Skip 'to' + angle
        // Skip 'deg' si c'est un token séparé
        if (currentIndex < tokens.length && tokens[currentIndex].value == 'deg') {
          currentIndex++;
        }
      } else if (token.value == 'with') {
        hasArrowAtEnd = true;
        currentIndex++;
        
        // Check for + or - for arrow direction
        if (currentIndex < tokens.length) {
          if (tokens[currentIndex].value == '+') {
            arrowCounterClockwise = true;
            currentIndex++;
          } else if (tokens[currentIndex].value == '-') {
            arrowCounterClockwise = false;
            currentIndex++;
          }
        }
        
        // Skip 'arrow', 'at', 'end'
        while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
          if (tokens[currentIndex].value == 'arrow' || 
              tokens[currentIndex].value == 'at' || 
              tokens[currentIndex].value == 'end') {
            currentIndex++;
          } else if (_isNextCommand(tokens, currentIndex)) {
            break;
          } else {
            currentIndex++;
          }
        }
      } else {
        currentIndex++;
      }
    }
    
    // Convertir en radians
    double sweepAngle = (endAngle - startAngle) * math.pi / 180;
    startAngle = startAngle * math.pi / 180;
    
    return ArcElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: ParsingUtils.parseColorString(color),
      width: width,
      center: center,
      radius: radius,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      hasArrowAtEnd: hasArrowAtEnd,
      arrowCounterClockwise: arrowCounterClockwise,
      fillColor: ParsingUtils.parseColorString(fillColor),
    );
  }

  /// Parse une valeur d'angle qui peut être "180" ou "180deg"
  double _parseAngleValue(String value) {
    if (value.endsWith('deg')) {
      return double.parse(value.substring(0, value.length - 3));
    }
    return double.parse(value);
  }

  bool _isNextCommand(List<Token> tokens, int index) {
    if (index >= tokens.length) return false;
    return tokens[index].value == 'start' ||
           tokens[index].value == 'for' ||
           tokens[index].value == 'color' ||
           tokens[index].value == 'fillcolor' ||
           tokens[index].value == 'width' ||
           tokens[index].value == 'radius' ||
           tokens[index].value == 'at' ||
           tokens[index].value == 'from' ||
           tokens[index].value == 'to';
  }
}