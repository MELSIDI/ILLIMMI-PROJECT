// tokenizer/token_types.dart
class Token {
  final TokenType type;
  final String value;
  final int position;

  Token(this.type, this.value, this.position);
}

enum TokenType {
  KEYWORD, IDENTIFIER, NUMBER, STRING, PUNCTUATION, 
  OPERATOR, COMMENT, WHITESPACE, EOF
}