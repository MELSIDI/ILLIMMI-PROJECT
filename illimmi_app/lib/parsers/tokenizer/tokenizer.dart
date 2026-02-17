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
      } else if (_currentChar == '"') {
        tokens.add(Token(TokenType.STRING, _parseString(), _position));
      } else if (_currentChar == "'") {
        tokens.add(Token(TokenType.STRING, _parseLatexString(), _position));
      } else if (_isDigit(_currentChar)) {
        // Regarder si c'est un nombre ou un identifiant comme "2drep"
        if (_isStartOfIdentifier()) {
          tokens.add(Token(TokenType.IDENTIFIER, _parseIdentifier(), _position));
        } else {
          tokens.add(Token(TokenType.NUMBER, _parseNumber(), _position));
        }
      } else if (_currentChar == '-' || _currentChar == '+') {
        // Check if it's a negative number or an operator
        if (_position + 1 < script.length && _isDigit(script[_position + 1])) {
          tokens.add(Token(TokenType.NUMBER, _parseNumber(), _position));
        } else {
          tokens.add(Token(TokenType.OPERATOR, _currentChar, _position));
          _advance();
        }
      } else if (_isAlpha(_currentChar) || _currentChar == '_') {
        tokens.add(Token(TokenType.IDENTIFIER, _parseIdentifier(), _position));
      } else {
        tokens.add(Token(TokenType.PUNCTUATION, _currentChar, _position));
        _advance();
      }
    }
    
    tokens.add(Token(TokenType.EOF, '', _position));
    return tokens;
  }

  // Vérifier si on est au début d'un identifiant comme "2drep" ou "2dfunc"
  // mais PAS "0s", "2s", "10ms" etc. (unités de temps)
  bool _isStartOfIdentifier() {
    if (!_isDigit(_currentChar)) return false;
    
    // Regarder en avant pour voir si après les chiffres il y a des lettres
    int lookahead = _position;
    String digits = '';
    
    // Collecter les chiffres et le point décimal
    while (lookahead < script.length && 
           (_isDigit(script[lookahead]) || script[lookahead] == '.')) {
      digits += script[lookahead];
      lookahead++;
    }
    
    // Si on trouve une lettre après les chiffres
    if (lookahead < script.length && _isAlpha(script[lookahead])) {
      String nextChar = script[lookahead];
      
      // Si c'est une unité de temps (s, ms, min, h), ce n'est PAS un identifiant
      if (nextChar == 's' || nextChar == 'm' || nextChar == 'h') {
        // Vérifier si c'est "ms" (milliseconde)
        if (nextChar == 'm' && lookahead + 1 < script.length && script[lookahead + 1] == 's') {
          return false; // C'est un nombre avec unité "ms"
        }
        // Vérifier si c'est "min" (minute)
        if (nextChar == 'm' && lookahead + 2 < script.length && 
            script[lookahead + 1] == 'i' && script[lookahead + 2] == 'n') {
          return false; // C'est un nombre avec unité "min"
        }
        // Pour "s" ou "h" seuls
        return false; // C'est un nombre avec unité
      }
      
      // Sinon, c'est un vrai identifiant comme "2drep", "2dfunc"
      return true;
    }
    
    return false;
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
    // Permettre identifiants qui commencent par chiffres (2drep, 2dfunc)
    // et contiennent lettres, chiffres, underscores
    while (_isAlphaNumeric(_currentChar) || _currentChar == '_') {
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
  bool _isAlpha(String char) => char.isNotEmpty && RegExp(r'[a-zA-Z]').hasMatch(char);
  bool _isAlphaNumeric(String char) => _isAlpha(char) || _isDigit(char);
}