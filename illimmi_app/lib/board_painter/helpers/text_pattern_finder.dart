// helpers/text_pattern_finder.dart (Solution optimale avec TextPainter)
import 'package:flutter/material.dart';
import '../../models/basic_elements/text_element.dart';

/// Classe utilitaire pour trouver des patterns dans les TextElement
/// Utilise TextPainter.getBoxesForSelection() pour une précision parfaite
class TextPatternFinder {
  static const double PIXEL_TO_REFERENCE = 1/5; // Ratio de conversion

  /// Trouve la position exacte d'un pattern dans le texte
  static Offset? findPatternPosition(
    TextElement textElement,
    String pattern,
    double fontSize,
  ) {
    print('🔍 Recherche pattern "$pattern" dans: ${textElement.content}');
    
    if (pattern.isEmpty) {
      return _measureTextCenter(textElement, fontSize);
    }

    // Nettoyer le contenu des balises de style
    final cleanContent = _removeStyleTags(textElement.content);
    print('   ➜ Contenu nettoyé: "$cleanContent"');
    
    // Chercher le pattern
    final patternIndex = cleanContent.indexOf(pattern);
    
    if (patternIndex == -1) {
      print('   ⚠️  Pattern non trouvé');
      return _measureTextCenter(textElement, fontSize);
    }

    print('   ➜ Pattern trouvé à l\'index $patternIndex');

    // Mesurer avec TextPainter et getBoxesForSelection
    return _measurePatternWithBoxes(
      cleanContent,
      patternIndex,
      pattern.length,
      fontSize,
      textElement,
    );
  }
  
  /// Point de départ intelligent selon la direction
  static Offset? findTextStartPosition(
    TextElement fromText,
    TextElement toText,
    double fontSize,
  ) {
    print('📍 Calcul position de départ intelligente');
    
    final deltaX = toText.position.dx - fromText.position.dx;
    final deltaY = toText.position.dy - fromText.position.dy;
    
    print('   Delta: (Δx=$deltaX, Δy=$deltaY)');
    
    // Mesurer les dimensions du texte source
    final textSize = _measureTextSize(fromText.content, fontSize);
    
    print('   Dimensions: ${textSize.width} × ${textSize.height}');
    
    double startX, startY;
    
    if (deltaX.abs() > deltaY.abs()) {
      if (deltaX > 0) {
        // → Droite : partir de la fin
        startX = fromText.position.dx + textSize.width * PIXEL_TO_REFERENCE /2;
        startY = fromText.position.dy + textSize.height * PIXEL_TO_REFERENCE * 1.5;
        print('   → Direction: DROITE');
      } else {
        // ← Gauche : partir du début
        startX = fromText.position.dx;
        startY = fromText.position.dy + textSize.height * PIXEL_TO_REFERENCE  / 2;
        print('   → Direction: GAUCHE');
      }
    } else {
      if (deltaY > 0) {
        // ↓ Bas
        startX = fromText.position.dx + textSize.width * PIXEL_TO_REFERENCE / 2;
        startY = fromText.position.dy + textSize.height * PIXEL_TO_REFERENCE;
        print('   → Direction: BAS');
      } else {
        // ↑ Haut
        startX = fromText.position.dx + textSize.width / 2;
        startY = fromText.position.dy;
        print('   → Direction: HAUT');
      }
    }
    
    return Offset(startX, startY);
  }

  /// Mesure la position d'un pattern avec getBoxesForSelection
  static Offset _measurePatternWithBoxes(
    String text,
    int patternIndex,
    int patternLength,
    double fontSize,
    TextElement textElement,
  ) {
    // Créer le TextPainter
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Roboto',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // Obtenir les boxes pour le pattern sélectionné
    final selection = TextSelection(
      baseOffset: patternIndex,
      extentOffset: patternIndex + patternLength,
    );
    
    final boxes = textPainter.getBoxesForSelection(selection);
    
    if (boxes.isEmpty) {
      print('   ⚠️  Aucune box trouvée pour le pattern');
      return _measureTextCenter(textElement, fontSize);
    }

    // Prendre la première box (ou fusionner si plusieurs lignes)
    final box = boxes.first;
    
    // Calculer le centre du pattern
    final patternCenterX = (box.left + box.right) / 2;
    final patternCenterY = (box.top + box.bottom) / 2;
    
    print('     • Box pattern (pixels): left=${box.left.toStringAsFixed(1)}, '
          'top=${box.top.toStringAsFixed(1)}, '
          'right=${box.right.toStringAsFixed(1)}, '
          'bottom=${box.bottom.toStringAsFixed(1)}');
    
    // Convertir en unités de référence
    final centerXInRef = patternCenterX * PIXEL_TO_REFERENCE;
    final centerYInRef = patternCenterY * PIXEL_TO_REFERENCE;
    
    print('     • Centre pattern (référence): $centerXInRef, $centerYInRef');
    
    // Ajouter la position du TextElement
    final finalX = textElement.position.dx + centerXInRef;
    final finalY = textElement.position.dy + centerYInRef;
    
    print('     • Position finale: ($finalX, $finalY)');
    
    return Offset(finalX, finalY);
  }

  /// Mesure les dimensions totales du texte
  static Size _measureTextSize(String content, double fontSize) {
    final cleanContent = _removeStyleTags(content);
    
    final textPainter = TextPainter(
      text: TextSpan(
        text: cleanContent,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Roboto',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    
    return Size(
      textPainter.width * PIXEL_TO_REFERENCE,
      textPainter.height * PIXEL_TO_REFERENCE,
    );
  }

  /// Mesure le centre du texte
  static Offset _measureTextCenter(TextElement textElement, double fontSize) {
    final textSize = _measureTextSize(textElement.content, fontSize);
    
    return Offset(
      textElement.position.dx + textSize.width / 2,
      textElement.position.dy + textSize.height / 2,
    );
  }

  /// Retire les balises de style du contenu
  static String _removeStyleTags(String content) {
    String cleaned = content;
    
    // Retirer les balises de style [bold], [italic], [color=...], etc.
    final styleTagPattern = RegExp(r'\[(?:\/)?(?:bold|italic|color=[^]]+|font=[^]]+)\]');
    cleaned = cleaned.replaceAll(styleTagPattern, '');
    
    // Retirer les délimiteurs LaTeX mais garder le contenu
    // $$...$$ ou $...$ devient ...
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'\$\$([^$]+)\$\$|\$([^$]+)\$'),
      (match) => match.group(1) ?? match.group(2) ?? '',
    );
    
    return cleaned;
  }

  /// Trouve un TextElement par ID
  static TextElement? findTextElementById(
    List<TextElement> textElements,
    int id,
  ) {
    try {
      return textElements.firstWhere((element) => element.id == id);
    } catch (e) {
      print('⚠️  TextElement $id non trouvé');
      return null;
    }
  }
}