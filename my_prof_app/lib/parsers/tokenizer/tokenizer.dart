// tokenizer/tokenizer.dart
import 'token_types.dart';

class Tokenizer {
  final String script;
  int _position = 0;
  String _currentChar = '';
  
  Tokenizer(this.script) {
    if (script.isNotEmpty) {
      _currentChar = script[0];
    }
  }

  List<Token> tokenize() {
    List<Token> tokens = [];
    
    while (_currentChar.isNotEmpty) {
      if (_isWhitespace(_currentChar)) {
        tokens.add(Token(TokenType.WHITESPACE, _skipWhitespace(), _position));
      } else if (_currentChar == '#') {
        tokens.add(Token(TokenType.COMMENT, _skipComment(), _position));
      } else if (_isDigit(_currentChar) || _currentChar == '-' || _currentChar == '+') {
        tokens.add(Token(TokenType.NUMBER, _parseNumber(), _position));
      } else if (_currentChar == '"') {
        tokens.add(Token(TokenType.STRING, _parseString(), _position));
      } else if (_currentChar == "'") {
        tokens.add(Token(TokenType.STRING, _parseLatexString(), _position));
      } else if (_isAlpha(_currentChar)) {
        tokens.add(Token(TokenType.IDENTIFIER, _parseIdentifier(), _position));
      } else {
        tokens.add(Token(TokenType.PUNCTUATION, _currentChar, _position));
        _advance();
      }
    }
    
    tokens.add(Token(TokenType.EOF, '', _position));
    return tokens;
  }

  String _skipWhitespace() {
    String whitespace = '';
    while (_isWhitespace(_currentChar)) {
      whitespace += _currentChar;
      _advance();
    }
    return whitespace;
  }

  String _skipComment() {
    String comment = '';
    while (_currentChar != '\n' && _currentChar.isNotEmpty) {
      comment += _currentChar;
      _advance();
    }
    return comment;
  }

  String _parseNumber() {
    String numStr = '';
    
    if (_currentChar == '-' || _currentChar == '+') {
      numStr += _currentChar;
      _advance();
    }
    
    while (_isDigit(_currentChar) || _currentChar == '.') {
      numStr += _currentChar;
      _advance();
    }
    
    return numStr;
  }

  String _parseString() {
    String result = '';
    _advance(); // Skip opening quote
    
    while (_currentChar != '"' && _currentChar.isNotEmpty) {
      result += _currentChar;
      _advance();
    }
    
    _advance(); // Skip closing quote
    return result;
  }

  String _parseLatexString() {
    String result = '';
    _advance(); // Skip first quote
    
    if (_currentChar == "'") {
      _advance(); // Skip second quote
    } else {
      throw Exception("Attendu '' pour une chaîne LaTeX");
    }
    
    while (true) {
      if (_currentChar == "'" && _position + 1 < script.length && script[_position + 1] == "'") {
        _advance();
        _advance();
        break;
      }
      if (_currentChar.isEmpty) break;
      result += _currentChar;
      _advance();
    }
    
    return result;
  }

  String _parseIdentifier() {
    String identifier = '';
    while (_isAlphaNumeric(_currentChar)) {
      identifier += _currentChar;
      _advance();
    }
    return identifier;
  }

  void _advance() {
    _position++;
    if (_position < script.length) {
      _currentChar = script[_position];
    } else {
      _currentChar = '';
    }
  }

  bool _isWhitespace(String char) => char == ' ' || char == '\t' || char == '\n' || char == '\r';
  bool _isDigit(String char) => char.isNotEmpty && '0123456789'.contains(char);
  bool _isAlpha(String char) => char.isNotEmpty && RegExp(r'[a-zA-Z_]').hasMatch(char);
  bool _isAlphaNumeric(String char) => _isAlpha(char) || _isDigit(char);
}