// draw_parsers/line_draw_parser.dart (Enhanced)
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/line_element.dart';
import '../../models/draw_elements/arrow_element.dart';  
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class LineDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'line' || drawType == 'arrow';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    bool isArrow = tokens[startIndex].value == 'arrow';
    
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    double width = 2.5;
    List<Offset>? points;
    int? fromTextId;
    int? toTextId;
    String? toTextPattern;
    
    int currentIndex = startIndex + 2; // Skip draw type and id
    
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
        currentIndex += 6; // color ( r , g , b , a )
      } else if (token.value == 'width') {
        width = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'at') {
        // Vérifier si c'est une syntaxe avec références textuelles ou coordonnées
        currentIndex++; // Skip 'at'
        
        if (tokens[currentIndex].value == '(') {
          // Vérifier si c'est (id1, id2) ou (id1, id2, "pattern")
          if (_isTextReferenceFormat(tokens, currentIndex)) {
            final result = _parseTextReference(tokens, currentIndex);
            fromTextId = result['fromId'];
            toTextId = result['toId'];
            toTextPattern = result['pattern'];
            currentIndex = result['nextIndex'];
          } else {
            // Format classique avec liste de points
            points = ParsingUtils.parsePointList(tokens, currentIndex - 1);
            currentIndex += points.length * 3 + 2; // [ (x,y), ... ]
          }
        } else if (tokens[currentIndex].value == '[') {
          // Format classique avec liste de points
          points = ParsingUtils.parsePointList(tokens, currentIndex);
          currentIndex += points.length * 3 + 2; // [ (x,y), ... ]
        }
      } else {
        currentIndex++;
      }
    }
    
    // Créer l'élément selon le format détecté
    if (fromTextId != null && toTextId != null) {
      // Format avec références textuelles
      if (isArrow) {
        return ArrowElement(
          id: id,
          startTime: startTime,
          duration: duration,
          color: ParsingUtils.parseColorString(color),
          width: width,
          fromTextId: fromTextId,
          toTextId: toTextId,
          toTextPattern: toTextPattern,
        );
      } else {
        return LineElement(
          id: id,
          startTime: startTime,
          duration: duration,
          color: ParsingUtils.parseColorString(color),
          width: width,
          fromTextId: fromTextId,
          toTextId: toTextId,
          toTextPattern: toTextPattern,
        );
      }
    } else {
      // Format classique avec coordonnées
      if (points == null || points.length < 2) {
        throw Exception('Une ligne nécessite au moins 2 points');
      }
      
      if (isArrow) {
        return ArrowElement(
          id: id,
          startTime: startTime,
          duration: duration,
          color: ParsingUtils.parseColorString(color),
          width: width,
          from: points[0],
          to: points[1],
        );
      } else {
        return LineElement(
          id: id,
          startTime: startTime,
          duration: duration,
          color: ParsingUtils.parseColorString(color),
          width: width,
          from: points[0],
          to: points[1],
        );
      }
    }
  }

  /// Vérifie si le format est une référence textuelle (id1, id2) ou (id1, id2, "pattern")
  bool _isTextReferenceFormat(List<Token> tokens, int startIndex) {
    if (startIndex + 4 >= tokens.length) return false;
    
    // Vérifier le pattern: ( NUMBER , NUMBER )
    return tokens[startIndex].value == '(' &&
           tokens[startIndex + 1].type == TokenType.NUMBER &&
           tokens[startIndex + 2].value == ',' &&
           tokens[startIndex + 3].type == TokenType.NUMBER &&
           (tokens[startIndex + 4].value == ')' || 
            tokens[startIndex + 4].value == ',');
  }

  /// Parse une référence textuelle: (id1, id2) ou (id1, id2, "pattern")
  Map<String, dynamic> _parseTextReference(List<Token> tokens, int startIndex) {
    int currentIndex = startIndex;
    
    if (tokens[currentIndex].value != '(') {
      throw Exception('Parenthèse ouvrante attendue à la position ${tokens[currentIndex].position}');
    }
    currentIndex++; // Skip '('
    
    // Lire fromId
    if (tokens[currentIndex].type != TokenType.NUMBER) {
      throw Exception('ID de texte source attendu à la position ${tokens[currentIndex].position}');
    }
    final fromId = int.parse(tokens[currentIndex].value);
    currentIndex++; // Skip number
    
    // Skip ','
    if (tokens[currentIndex].value != ',') {
      throw Exception('Virgule attendue à la position ${tokens[currentIndex].position}');
    }
    currentIndex++; // Skip ','
    
    // Lire toId
    if (tokens[currentIndex].type != TokenType.NUMBER) {
      throw Exception('ID de texte cible attendu à la position ${tokens[currentIndex].position}');
    }
    final toId = int.parse(tokens[currentIndex].value);
    currentIndex++; // Skip number
    
    String? pattern;
    
    // Vérifier s'il y a un pattern
    if (tokens[currentIndex].value == ',') {
      currentIndex++; // Skip ','
      
      if (tokens[currentIndex].type != TokenType.STRING) {
        throw Exception('Pattern (string) attendu à la position ${tokens[currentIndex].position}');
      }
      pattern = tokens[currentIndex].value;
      currentIndex++; // Skip string
    }
    
    // Skip ')'
    if (tokens[currentIndex].value != ')') {
      throw Exception('Parenthèse fermante attendue à la position ${tokens[currentIndex].position}');
    }
    currentIndex++; // Skip ')'
    
    return {
      'fromId': fromId,
      'toId': toId,
      'pattern': pattern,
      'nextIndex': currentIndex,
    };
  }
}


/*// draw_parsers/line_draw_parser.dart
import 'draw_parser_interface.dart';
import '../../models/hyper_element.dart';
import '../../models/draw_elements/line_element.dart';
import '../../models/draw_elements/arrow_element.dart';  
import '../tokenizer/token_types.dart';
import '../parsing_utils.dart';
import 'package:flutter/material.dart';

class LineDrawParser implements DrawParser {
  @override
  bool canParse(String drawType) => drawType == 'line' || drawType == 'arrow';

  @override
  HyperElement parse(List<Token> tokens, int startIndex) {
    bool isArrow = tokens[startIndex].value == 'arrow';
    
    int id = ParsingUtils.parseId(tokens, startIndex + 1);
    double startTime = 0;
    double duration = 0;
    String? color;
    double width = 2.5;
    List<Offset> points = [];
    
    int currentIndex = startIndex + 2; // Skip draw type and id
    
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
        currentIndex += 6; // color ( r , g , b , a )
      } else if (token.value == 'width') {
        width = double.parse(tokens[currentIndex + 1].value);
        currentIndex += 2;
      } else if (token.value == 'at') {
        points = ParsingUtils.parsePointList(tokens, currentIndex + 1);
        currentIndex += points.length * 3 + 2; // [ (x,y), ... ]
      } else {
        currentIndex++;
      }
    }
    
    if (points.length < 2) {
      throw Exception('Une ligne nécessite au moins 2 points');
    }
    
    if (isArrow) {
      return ArrowElement(
        id: id,
        startTime: startTime,
        duration: duration,
        color: ParsingUtils.parseColorString(color),
        width: width,
        from: points[0],
        to: points[1],
      );
    } else {
      return LineElement(
        id: id,
        startTime: startTime,
        duration: duration,
        color: ParsingUtils.parseColorString(color),
        width: width,
        from: points[0],
        to: points[1],
      );
    }
  }
}*/