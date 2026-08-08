// draw_parsers/circle_draw_parser.dart
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/circle_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import '../../hc_types.dart';

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
        
        // Skip 'arrow', 'on', puis parse l'angle
        while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
          if (tokens[currentIndex].value == 'arrow' || tokens[currentIndex].value == 'on') {
            currentIndex++;
          } else if (tokens[currentIndex].type == TokenType.NUMBER || 
                     tokens[currentIndex].type == TokenType.IDENTIFIER) {
            // Peut être "45" ou "45deg"
            String angleStr = tokens[currentIndex].value;
            arrowAngle = _parseAngleValue(angleStr);
            currentIndex++;
            // Skip 'deg' si c'est un token séparé
            if (currentIndex < tokens.length && tokens[currentIndex].value == 'deg') {
              currentIndex++;
            }
            break;
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

  /// Parse une valeur d'angle qui peut être "45" ou "45deg"
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
           tokens[index].value == 'at';
  }
}