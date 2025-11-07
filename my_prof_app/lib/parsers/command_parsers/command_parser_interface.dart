// command_parsers/command_parser_interface.dart
import '../../models/hyper_element.dart';
import '../tokenizer/token_types.dart';

abstract class CommandParser {
  bool canParse(String command);
  HyperElement parse(List<Token> tokens, int startIndex);
}