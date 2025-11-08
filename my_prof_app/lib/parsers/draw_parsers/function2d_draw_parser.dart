// draw_parsers/function2d_draw_parser.dart
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/function2d_element.dart'; 
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';

class Function2DDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == '2dfunc';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    double width = 2.5;
    int repereId = -1;
    String expression = '';
    
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
        repereId = int.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'y') {
        // Skip '=' qui est à currentIndex + 1
        int exprResult = _parseExpression(tokens, currentIndex + 2);
        expression = tokens.sublist(currentIndex + 2, exprResult)
            .map((t) => t.value)
            .join('');
        currentIndex = exprResult;
      } else {
        currentIndex++;
      }
    }
    
    if (repereId == -1) {
      throw Exception('2dfunc id $id: manque "at <id_repere>"');
    }
    
    if (expression.isEmpty) {
      throw Exception('2dfunc id $id: manque "y = <expression>"');
    }
    
    print('✅ 2dfunc parsé: id=$id, repereId=$repereId, expression="$expression"');
    
    return Function2DElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: ParsingUtils.parseColorString(color),
      width: width,
      repereId: repereId,
      expression: expression,
    );
  }

  /// Retourne l'index du token après l'expression (avant le ';')
  int _parseExpression(List<Token> tokens, int startIndex) {
    int currentIndex = startIndex;
    
    // Lire tous les tokens jusqu'au ';'
    while (currentIndex < tokens.length && tokens[currentIndex].value != ';') {
      currentIndex++;
    }
    
    return currentIndex;
  }
}