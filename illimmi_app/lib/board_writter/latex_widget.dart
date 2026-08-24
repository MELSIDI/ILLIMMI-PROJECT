import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

/// Widget avancé pour afficher du texte enrichi avec support LaTeX
/// Animation progressive sur le CONTENU VISIBLE uniquement (sans les tags)
class AdvancedTextWidget extends StatelessWidget {
  final String content;
  final double fontSize;
  final Color defaultColor;
  final String defaultFont;
  final double progress;

  const AdvancedTextWidget({
    super.key,
    required this.content,
    this.fontSize = 24.0,
    this.defaultColor = const Color(0xFFF2F6F3),
    this.defaultFont = 'Roboto',
    this.progress = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return const SizedBox.shrink();
    }
    
    // 1. Parser TOUT le contenu pour extraire la structure complète
    final fullStructure = _parseContentStructure(content);
    
    // 2. Calculer la longueur du texte VISIBLE (sans les tags)
    final totalVisibleLength = _calculateVisibleLength(fullStructure);
    
    // 3. Calculer combien de caractères visibles afficher selon progress
    final visibleCharsToShow = (totalVisibleLength * progress).round().clamp(0, totalVisibleLength);
    
    if (visibleCharsToShow <= 0) {
      return const SizedBox.shrink();
    }
    
    // 4. Générer les spans en limitant au nombre de caractères visibles
    final textSpans = _buildSpansWithLimit(fullStructure, visibleCharsToShow);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: fontSize,
                color: defaultColor,
                fontFamily: defaultFont,
              ),
              children: textSpans,
            ),
          ),
        ),
        // Curseur clignotant pendant l'écriture
        if (progress < 1.0 && progress > 0.0)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 530),
            builder: (context, value, child) {
              return Opacity(
                opacity: value > 0.5 ? 1.0 : 0.3,
                child: Container(
                  width: 2,
                  height: fontSize,
                  color: defaultColor,
                  margin: const EdgeInsets.only(left: 2),
                ),
              );
            },
          ),
      ],
    );
  }

  /// Parse le contenu et retourne une structure de segments stylisés
  List<_ContentSegment> _parseContentStructure(String text) {
    List<_ContentSegment> segments = [];
    List<_StyleContext> styleStack = [_StyleContext()];
    
    int i = 0;
    StringBuffer currentText = StringBuffer();
    
    while (i < text.length) {
      // Détecter les balises de style
      if (text[i] == '[') {
        // Sauvegarder le texte accumulé
        if (currentText.isNotEmpty) {
          segments.add(_ContentSegment(
            type: _SegmentType.text,
            content: currentText.toString(),
            style: styleStack.last,
          ));
          currentText.clear();
        }
        
        // Parser la balise
        final tagEnd = text.indexOf(']', i);
        if (tagEnd != -1) {
          final tag = text.substring(i + 1, tagEnd);
          
          if (tag.startsWith('/')) {
            // Balise de fermeture
            if (styleStack.length > 1) {
              styleStack.removeLast();
            }
          } else if (tag == 'bold') {
            styleStack.add(styleStack.last.copyWith(bold: true));
          } else if (tag == 'italic') {
            styleStack.add(styleStack.last.copyWith(italic: true));
          } else if (tag.startsWith('color=')) {
            final colorStr = tag.substring(6);
            final color = _parseColor(colorStr);
            styleStack.add(styleStack.last.copyWith(color: color));
          } else if (tag.startsWith('font=')) {
            final font = tag.substring(5);
            styleStack.add(styleStack.last.copyWith(fontFamily: font));
          }
          
          i = tagEnd + 1;
          continue;
        }
      }
      
      // Détecter les formules mathématiques
      if (text[i] == '\$') {
        // Sauvegarder le texte accumulé
        if (currentText.isNotEmpty) {
          segments.add(_ContentSegment(
            type: _SegmentType.text,
            content: currentText.toString(),
            style: styleStack.last,
          ));
          currentText.clear();
        }
        
        // Détecter $$ ou $
        bool isDisplay = i + 1 < text.length && text[i + 1] == '\$';
        String delimiter = isDisplay ? '\$\$' : '\$';
        int mathStart = i + delimiter.length;
        int mathEnd = text.indexOf(delimiter, mathStart);
        
        if (mathEnd != -1) {
          String mathContent = text.substring(mathStart, mathEnd);
          segments.add(_ContentSegment(
            type: isDisplay ? _SegmentType.mathDisplay : _SegmentType.mathInline,
            content: mathContent,
            style: styleStack.last,
          ));
          i = mathEnd + delimiter.length;
          continue;
        }
      }
      
      // Caractère normal
      currentText.write(text[i]);
      i++;
    }
    
    // Ajouter le reste du texte
    if (currentText.isNotEmpty) {
      segments.add(_ContentSegment(
        type: _SegmentType.text,
        content: currentText.toString(),
        style: styleStack.last,
      ));
    }
    
    return segments;
  }

  /// Calcule la longueur totale du texte visible (sans compter les formules comme 1 char)
  int _calculateVisibleLength(List<_ContentSegment> segments) {
    int total = 0;
    for (var segment in segments) {
      if (segment.type == _SegmentType.text) {
        total += segment.content.length;
      } else {
        // Les formules mathématiques comptent comme 1 caractère pour l'animation
        total += 1;
      }
    }
    return total;
  }

  /// Construit les spans en limitant au nombre de caractères visibles
  List<InlineSpan> _buildSpansWithLimit(List<_ContentSegment> segments, int maxVisibleChars) {
    List<InlineSpan> spans = [];
    int currentVisibleCount = 0;
    
    for (var segment in segments) {
      if (currentVisibleCount >= maxVisibleChars) break;
      
      if (segment.type == _SegmentType.text) {
        // Texte normal
        int remainingChars = maxVisibleChars - currentVisibleCount;
        String textToShow = segment.content.length <= remainingChars
            ? segment.content
            : segment.content.substring(0, remainingChars);
        
        spans.add(_buildTextSpan(textToShow, segment.style));
        currentVisibleCount += textToShow.length;
      } else {
        // Formule mathématique (affichée entièrement ou pas du tout)
        if (currentVisibleCount < maxVisibleChars) {
          spans.add(_buildMathSpan(
            segment.content,
            segment.type == _SegmentType.mathDisplay,
            segment.style,
          ));
          currentVisibleCount += 1; // Les maths comptent comme 1 char
        }
      }
    }
    
    return spans;
  }

  TextSpan _buildTextSpan(String text, _StyleContext style) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: style.color ?? defaultColor,
        fontFamily: style.fontFamily ?? defaultFont,
        fontWeight: style.bold ? FontWeight.bold : FontWeight.normal,
        fontStyle: style.italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }

  WidgetSpan _buildMathSpan(String latex, bool isDisplay, _StyleContext style) {
    try {
      return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDisplay ? 8.0 : 2.0,
            vertical: isDisplay ? 4.0 : 0.0,
          ),
          child: Math.tex(
            latex,
            textStyle: TextStyle(
              fontSize: isDisplay ? fontSize * 1.2 : fontSize,
              color: style.color ?? defaultColor,
            ),
            mathStyle: isDisplay ? MathStyle.display : MathStyle.text,
          ),
        ),
      );
    } catch (e) {
      // Fallback si le LaTeX est invalide
      return WidgetSpan(
        child: Text(
          latex,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.red,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
  }

  Color _parseColor(String colorStr) {
    try {
      if (colorStr.startsWith('#')) {
        return Color(int.parse(colorStr.substring(1), radix: 16) + 0xFF000000);
      }
      return defaultColor;
    } catch (e) {
      return defaultColor;
    }
  }
}

/// Type de segment de contenu
enum _SegmentType {
  text,
  mathInline,
  mathDisplay,
}

/// Représente un segment de contenu avec son style
class _ContentSegment {
  final _SegmentType type;
  final String content;
  final _StyleContext style;

  _ContentSegment({
    required this.type,
    required this.content,
    required this.style,
  });
}

/// Contexte de style pour un segment
class _StyleContext {
  final Color? color;
  final String? fontFamily;
  final bool bold;
  final bool italic;

  _StyleContext({
    this.color,
    this.fontFamily,
    this.bold = false,
    this.italic = false,
  });

  _StyleContext copyWith({
    Color? color,
    String? fontFamily,
    bool? bold,
    bool? italic,
  }) {
    return _StyleContext(
      color: color ?? this.color,
      fontFamily: fontFamily ?? this.fontFamily,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
    );
  }
}

// Alias pour garder la compatibilité
class LatexWidget extends StatelessWidget {
  final String content;
  final double fontSize;
  final Color color;
  final double progress;

  const LatexWidget({
    super.key,
    required this.content,
    this.fontSize = 24.0,
    this.color = const Color(0xFFF2F6F3),
    this.progress = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AdvancedTextWidget(
      content: content,
      fontSize: fontSize,
      defaultColor: color,
      progress: progress,
    );
  }
}