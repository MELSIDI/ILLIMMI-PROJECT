// draw_parsers/curve_draw_parser.dart
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/curve_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import '../../hc_types.dart';

class CurveDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'curve';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    double width = 2.5;
    List<Offset> points = [];
    bool smooth = true;
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
      } else if (token.value == 'color') {
        color = ParsingUtils.parseColor(tokens, currentIndex);
        currentIndex += 6;
      } else if (token.value == 'width') {
        width = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'smooth') {
        smooth = true;
        currentIndex++;
      } else if (token.value == 'bezier') {
        smooth = false;
        currentIndex++;
      } else if (token.value == 'at') {
        points = ParsingUtils.parsePointList(tokens, currentIndex + 1);
        // Calculer combien de tokens ont été consommés
        // Format: at [(x1, y1), (x2, y2), ...]
        // = 'at' + '[' + pour chaque point: '(' + x + ',' + y + ')' + ',' + ']'
        int pointTokens = 2; // 'at' + '['
        for (int i = 0; i < points.length; i++) {
          pointTokens += 5; // '(' + x + ',' + y + ')'
          if (i < points.length - 1) pointTokens++; // ','
        }
        pointTokens++; // ']'
        currentIndex += pointTokens;
      } else if (token.value == 'with') {
        hasArrowAtEnd = true;
        currentIndex++; // skip 'with'
        
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
    
    if (points.length < 2) {
      throw Exception('Une courbe nécessite au moins 2 points');
    }
    
    return CurveElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: ParsingUtils.parseColorString(color),
      width: width,
      points: points,
      smooth: smooth,
      hasArrowAtEnd: hasArrowAtEnd,
      arrowCounterClockwise: arrowCounterClockwise,
    );
  }

  bool _isNextCommand(List<Token> tokens, int index) {
    if (index >= tokens.length) return false;
    return tokens[index].value == 'start' ||
           tokens[index].value == 'for' ||
           tokens[index].value == 'color' ||
           tokens[index].value == 'width' ||
           tokens[index].value == 'smooth' ||
           tokens[index].value == 'bezier';
  }
}