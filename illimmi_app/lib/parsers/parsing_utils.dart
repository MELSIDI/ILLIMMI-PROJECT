// parsing_utils.dart
import 'package:flutter/material.dart';
import 'tokenizer/token_types.dart';

class ParsingUtils {
  static int parseId(List<Token> tokens, int startIndex) {
    if (startIndex + 1 < tokens.length &&
        (tokens[startIndex].value == 'id' || tokens[startIndex].value == 'idgap') &&
        tokens[startIndex + 1].type == TokenType.NUMBER) {
      return int.parse(tokens[startIndex + 1].value);
    }
    throw Exception('ID attendu à la position ${tokens[startIndex].position}');
  }

  static double parseTime(List<Token> tokens, int startIndex) {
    if (startIndex + 2 < tokens.length &&
        tokens[startIndex + 1].type == TokenType.NUMBER &&
        tokens[startIndex + 2].value == 's') {
      return double.parse(tokens[startIndex + 1].value);
    }
    throw Exception('Temps attendu à la position ${tokens[startIndex].position}');
  }

  static String parseAudioPath(List<Token> tokens, int startIndex) {
    if (startIndex + 1 < tokens.length &&
        tokens[startIndex].value == 'audio' &&
        tokens[startIndex + 1].type == TokenType.STRING) {
      return tokens[startIndex + 1].value;
    }
    throw Exception('Chemin audio attendu à la position ${tokens[startIndex].position}');
  }

  static String parseColor(List<Token> tokens, int startIndex) {
    if (startIndex + 9 < tokens.length &&
        tokens[startIndex + 1].value == '(' &&
        tokens[startIndex + 2].type == TokenType.NUMBER &&
        tokens[startIndex + 3].value == ',' &&
        tokens[startIndex + 4].type == TokenType.NUMBER &&
        tokens[startIndex + 5].value == ',' &&
        tokens[startIndex + 6].type == TokenType.NUMBER &&
        tokens[startIndex + 7].value == ',' &&
        tokens[startIndex + 8].type == TokenType.NUMBER &&
        tokens[startIndex + 9].value == ')') {
      
      return '${tokens[startIndex + 2].value},${tokens[startIndex + 4].value},${tokens[startIndex + 6].value},${tokens[startIndex + 8].value}';
    }
    throw Exception('Couleur attendue à la position ${tokens[startIndex].position}');
  }

  static Color? parseColorString(String? colorStr) {
    if (colorStr == null) return null;
    final parts = colorStr.split(',');
    if (parts.length == 4) {
      return Color.fromRGBO(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
        double.parse(parts[3]),
      );
    }
    return null;
  }

  static Offset parsePoint(List<Token> tokens, int startIndex) {
    if (startIndex + 4 < tokens.length &&
        tokens[startIndex].value == '(' &&
        tokens[startIndex + 1].type == TokenType.NUMBER &&
        tokens[startIndex + 2].value == ',' &&
        tokens[startIndex + 3].type == TokenType.NUMBER &&
        tokens[startIndex + 4].value == ')') {
      
      return Offset(
        double.parse(tokens[startIndex + 1].value),
        double.parse(tokens[startIndex + 3].value),
      );
    }
    throw Exception('Point attendu à la position ${tokens[startIndex].position}');
  }

  static List<Offset> parsePointList(List<Token> tokens, int startIndex) {
    List<Offset> points = [];
    int currentIndex = startIndex;
    
    if (currentIndex >= tokens.length || tokens[currentIndex].value != '[') {
      throw Exception('Liste de points attendue à la position ${tokens[startIndex].position}');
    }
    currentIndex++;
    
    while (currentIndex < tokens.length && tokens[currentIndex].value != ']') {
      if (tokens[currentIndex].value == '(') {
        points.add(parsePoint(tokens, currentIndex));
        currentIndex += 5; // Skip (x,y)
      } else if (tokens[currentIndex].value == ',') {
        currentIndex++;
      } else {
        currentIndex++;
      }
    }
    
    return points;
  }

  static List<double> parseRange(List<Token> tokens, int startIndex) {
    if (startIndex + 4 < tokens.length &&
        tokens[startIndex].value == '[' &&
        tokens[startIndex + 1].type == TokenType.NUMBER &&
        tokens[startIndex + 2].value == ',' &&
        tokens[startIndex + 3].type == TokenType.NUMBER &&
        tokens[startIndex + 4].value == ']') {
      
      return [
        double.parse(tokens[startIndex + 1].value),
        double.parse(tokens[startIndex + 3].value),
      ];
    }
    throw Exception('Plage attendue à la position ${tokens[startIndex].position}');
  }
}