// command_parsers/command_parser_factory.dart
import 'command_parser_interface.dart';
import 'draw_command_parser.dart';
import 'text_command_parser.dart';
import 'plot_command_parser.dart';
import 'erase_command_parser.dart';
import 'speech_command_parser.dart';
import 'mouse_command_parser.dart';

class CommandParserFactory {
  static final List<CommandParser> _parsers = [
    DrawCommandParser(),
    TextCommandParser(),
    PlotCommandParser(),
    EraseCommandParser(),
    SpeechCommandParser(),
    MouseCommandParser(),
  ];

  static CommandParser? getParser(String command) {
    for (final parser in _parsers) {
      if (parser.canParse(command)) {
        return parser;
      }
    }
    return null;
  }

  static void registerParser(CommandParser parser) {
    _parsers.add(parser);
  }
}