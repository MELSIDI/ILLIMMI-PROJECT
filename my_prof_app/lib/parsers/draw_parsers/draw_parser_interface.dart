// draw_parsers/draw_parser_interface.dart
import '../../models/hyper_element.dart';
import '../tokenizer/token_types.dart';

abstract class DrawParser {
  bool canParse(String drawType);
  HyperElement parse(List<Token> tokens, int startIndex);
}