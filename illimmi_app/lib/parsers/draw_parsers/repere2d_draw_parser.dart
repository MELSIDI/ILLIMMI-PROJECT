// draw_parsers/repere2d_draw_parser.dart
import 'package:flutter/material.dart';
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/repere2d_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';

class Repere2DDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == '2drep';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    Offset origin = const Offset(88.89, 50);
    String? color;
    double width = 1.5;
    double scale = 6.0;
    double xMin = -10;
    double xMax = 10;
    double yMin = -10;
    double yMax = 10;
    bool grid = false;
    double gridAlpha = 0.7;
    double step = 1.0;
    bool showLabels = false;
    
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
        origin = ParsingUtils.parsePoint(tokens, currentIndex + 1);
        currentIndex += 4;
      } else if (token.value == 'color') {
        color = ParsingUtils.parseColor(tokens, currentIndex);
        currentIndex += 6;
      } else if (token.value == 'width') {
        width = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'scale') {
        if (currentIndex + 1 < tokens.length && tokens[currentIndex + 1].value == '=') {
          scale = double.parse(tokens[currentIndex + 2].value);
          currentIndex += 3;
        } else {
          scale = double.parse(tokens[currentIndex + 1].value);
          currentIndex += 2;
        }
      } else if (token.value == 'grid' || token.value == 'grille') {
        if (currentIndex + 1 < tokens.length && tokens[currentIndex + 1].value == '=') {
          final val = tokens[currentIndex + 2].value.toLowerCase();
          grid = val == 'true' || val == '1' || val == 'yes';
          currentIndex += 3;
        } else if (currentIndex + 1 < tokens.length &&
            (tokens[currentIndex + 1].value.toLowerCase() == 'true' ||
             tokens[currentIndex + 1].value.toLowerCase() == 'false')) {
          grid = tokens[currentIndex + 1].value.toLowerCase() == 'true';
          currentIndex += 2;
        } else {
          grid = true;
          currentIndex += 1;
        }
      } else if (token.value == 'grid_alpha' || token.value == 'gridalpha') {
        if (currentIndex + 1 < tokens.length && tokens[currentIndex + 1].value == '=') {
          gridAlpha = double.parse(tokens[currentIndex + 2].value);
          currentIndex += 3;
        } else {
          gridAlpha = double.parse(tokens[currentIndex + 1].value);
          currentIndex += 2;
        }
      } else if (token.value == 'step' || token.value == 'graduation' || token.value == 'grad') {
        if (currentIndex + 1 < tokens.length && tokens[currentIndex + 1].value == '=') {
          final val = tokens[currentIndex + 2].value.toLowerCase();
          if (val == 'true') {
            step = 1.0;
          } else if (val == 'false') {
            step = 0.0;
          } else {
            step = double.tryParse(val) ?? 1.0;
          }
          currentIndex += 3;
        } else {
          final val = tokens[currentIndex + 1].value.toLowerCase();
          step = double.tryParse(val) ?? 1.0;
          currentIndex += 2;
        }
      } else if (token.value == 'show_labels' || token.value == 'labels') {
        if (currentIndex + 1 < tokens.length && tokens[currentIndex + 1].value == '=') {
          final val = tokens[currentIndex + 2].value.toLowerCase();
          showLabels = val == 'true' || val == '1' || val == 'yes';
          currentIndex += 3;
        } else {
          showLabels = true;
          currentIndex += 1;
        }
      } else if (token.value == 'x_range') {
        final range = ParsingUtils.parseRange(tokens, currentIndex + 2); // Skip '='
        xMin = range[0];
        xMax = range[1];
        currentIndex += 7;
      } else if (token.value == 'y_range') {
        final range = ParsingUtils.parseRange(tokens, currentIndex + 2); // Skip '='
        yMin = range[0];
        yMax = range[1];
        currentIndex += 7;
      } else {
        currentIndex++;
      }
    }
    
    return Repere2DElement(
      id: id,
      startTime: startTime,
      duration: duration,
      origin: origin,
      xStart: xMin,
      xEnd: xMax,
      yStart: yMin,
      yEnd: yMax,
      scale: scale,
      color: ParsingUtils.parseColorString(color),
      width: width,
      grid: grid,
      gridAlpha: gridAlpha,
      step: step,
      showLabels: showLabels,
    );
  }
}
