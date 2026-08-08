// draw_parsers/repere2d_draw_parser.dart
import '../../hc_types.dart';
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
    double scale = 1.0;
    double xMin = -10;
    double xMax = 10;
    double yMin = -10;
    double yMax = 10;
    
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
        scale = double.parse(tokens[currentIndex + 2].value); // Skip '='
        currentIndex += 3;
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
    );
  }
}