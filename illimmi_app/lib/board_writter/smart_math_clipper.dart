import 'package:flutter/material.dart';

/// Moteur de balayage géométrique 2D intelligent pour formules mathématiques.
///
/// Ce moteur décompose une formule en arbre de zones spatiales 2D (préfixes, fractions,
/// matrices, racines) et découpe géométriquement l'affichage via un `ClipPath`
/// dans l'ordre naturel d'écriture humaine :
/// - Fractions : Numérateur en haut -> Barre centrale -> Dénominateur en bas
/// - Matrices : Crochet ouvrant -> Cellules ligne par ligne -> Crochet fermant
/// - Racines : Radical -> Contenu sous la barre -> Toit supérieur
///
/// Avantage majeur : La formule LaTeX est compilée intacte (zéro syntax error)
/// et le masquage 2D garantit un rendu d'écriture ultra-naturel et ultra-fluide sur CPU.
class SmartMathClipper extends CustomClipper<Path> {
  final MathZone rootZone;
  final double progress;

  SmartMathClipper({
    required this.rootZone,
    required this.progress,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final p = progress.clamp(0.0, 1.0);
    if (p <= 0.0) return path; // vide
    if (p >= 1.0) {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
      return path;
    }

    rootZone.addClip(path, size, const Rect.fromLTWH(0, 0, 1, 1), p);
    return path;
  }

  @override
  bool shouldReclip(covariant SmartMathClipper oldClipper) {
    return oldClipper.progress != progress || oldClipper.rootZone != rootZone;
  }
}

/// Définition d'une zone spatiale dans une formule mathématique
abstract class MathZone {
  final double weight;

  MathZone({required this.weight});

  /// Ajoute les rectangles visibles au [path] pour la taille [totalSize],
  /// dans la boîte relative [relativeBox] (ex: Rect.fromLTWH(0, 0, 1, 1))
  /// pour un progrès local [localProgress ∈ [0.0, 1.0]].
  void addClip(Path path, Size totalSize, Rect relativeBox, double localProgress);
}

/// Séquence composée de plusieurs zones ordonnées (ex: Préfixe + Fraction + Suffixe)
class CompositeSequenceZone extends MathZone {
  final List<MathZone> children;
  final List<double> widthRatios;

  CompositeSequenceZone({
    required this.children,
    required this.widthRatios,
  }) : super(weight: children.fold(0.0, (sum, c) => sum + c.weight));

  @override
  void addClip(Path path, Size totalSize, Rect relativeBox, double localProgress) {
    final totalWeight = weight > 0 ? weight : 1.0;
    double currentWeightProgress = 0.0;
    double currentLeftNorm = relativeBox.left;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final childWidthRatio = i < widthRatios.length ? widthRatios[i] : (1.0 / children.length);
      final childBox = Rect.fromLTWH(
        currentLeftNorm,
        relativeBox.top,
        relativeBox.width * childWidthRatio,
        relativeBox.height,
      );

      final childWeightRatio = child.weight / totalWeight;
      final childStartP = currentWeightProgress;
      final childEndP = currentWeightProgress + childWeightRatio;

      if (localProgress >= childEndP) {
        // Enfant entièrement visible
        child.addClip(path, totalSize, childBox, 1.0);
      } else if (localProgress > childStartP) {
        // Enfant en cours de dessin
        final childProgress = (localProgress - childStartP) / childWeightRatio;
        child.addClip(path, totalSize, childBox, childProgress);
      }

      currentWeightProgress += childWeightRatio;
      currentLeftNorm += relativeBox.width * childWidthRatio;
    }
  }
}

/// Zone de texte ou symbole linéaire simple (balayage gauche à droite)
class LinearSegmentZone extends MathZone {
  LinearSegmentZone({required double weight}) : super(weight: weight);

  @override
  void addClip(Path path, Size totalSize, Rect relativeBox, double localProgress) {
    final p = localProgress.clamp(0.0, 1.0);
    if (p <= 0.0) return;

    final absoluteLeft = relativeBox.left * totalSize.width;
    final absoluteTop = relativeBox.top * totalSize.height;
    final absoluteWidth = relativeBox.width * totalSize.width * p;
    final absoluteHeight = relativeBox.height * totalSize.height;

    path.addRect(Rect.fromLTWH(absoluteLeft, absoluteTop, absoluteWidth, absoluteHeight));
  }
}

/// Zone de Fraction 2D (Numérateur en haut -> Barre au milieu -> Dénominateur en bas)
class Fraction2DZone extends MathZone {
  final MathZone numeratorZone;
  final MathZone denominatorZone;

  Fraction2DZone({
    required this.numeratorZone,
    required this.denominatorZone,
  }) : super(weight: numeratorZone.weight + 2.0 + denominatorZone.weight);

  @override
  void addClip(Path path, Size totalSize, Rect relativeBox, double localProgress) {
    final p = localProgress.clamp(0.0, 1.0);
    if (p <= 0.0) return;

    final wNum = numeratorZone.weight;
    const wBar = 1.5;
    final wDen = denominatorZone.weight;
    final totalW = wNum + wBar + wDen;

    final pNumEnd = wNum / totalW;
    final pBarEnd = (wNum + wBar) / totalW;

    final absoluteLeft = relativeBox.left * totalSize.width;
    final absoluteWidth = relativeBox.width * totalSize.width;
    final absoluteTop = relativeBox.top * totalSize.height;
    final absoluteHeight = relativeBox.height * totalSize.height;

    // Découpage vertical : Haut (numérateur), Milieu (barre), Bas (dénominateur)
    final barTop = absoluteTop + absoluteHeight * 0.44;
    final barHeight = absoluteHeight * 0.12;
    final numHeight = absoluteHeight * 0.44;
    final denTop = absoluteTop + absoluteHeight * 0.56;
    final denHeight = absoluteHeight * 0.44;

    // 1. Étape Numérateur (Haut)
    if (p <= pNumEnd) {
      final numProg = (p / pNumEnd).clamp(0.0, 1.0);
      path.addRect(Rect.fromLTWH(absoluteLeft, absoluteTop, absoluteWidth * numProg, numHeight));
      return;
    }

    // Le numérateur est 100% dessiné
    path.addRect(Rect.fromLTWH(absoluteLeft, absoluteTop, absoluteWidth, numHeight));

    // 2. Étape Barre centrale
    if (p <= pBarEnd) {
      final barProg = ((p - pNumEnd) / (pBarEnd - pNumEnd)).clamp(0.0, 1.0);
      path.addRect(Rect.fromLTWH(absoluteLeft, barTop, absoluteWidth * barProg, barHeight));
      return;
    }

    // La barre centrale est 100% dessinée
    path.addRect(Rect.fromLTWH(absoluteLeft, barTop, absoluteWidth, barHeight));

    // 3. Étape Dénominateur (Bas)
    final denProg = ((p - pBarEnd) / (1.0 - pBarEnd)).clamp(0.0, 1.0);
    path.addRect(Rect.fromLTWH(absoluteLeft, denTop, absoluteWidth * denProg, denHeight));
  }
}

/// Zone de Matrice 2D (Parenthèse gauche -> Ligne par ligne -> Parenthèse droite)
class Matrix2DZone extends MathZone {
  final int rows;
  final int cols;
  final List<MathZone> cellZones;

  Matrix2DZone({
    required this.rows,
    required this.cols,
    required this.cellZones,
  }) : super(weight: 2.0 + cellZones.fold(0.0, (sum, c) => sum + c.weight));

  @override
  void addClip(Path path, Size totalSize, Rect relativeBox, double localProgress) {
    final p = localProgress.clamp(0.0, 1.0);
    if (p <= 0.0) return;

    final absoluteLeft = relativeBox.left * totalSize.width;
    final absoluteTop = relativeBox.top * totalSize.height;
    final absoluteWidth = relativeBox.width * totalSize.width;
    final absoluteHeight = relativeBox.height * totalSize.height;

    const pOpenEnd = 0.05;
    const pCloseStart = 0.95;

    // 1. Parenthèse ouvrante gauche
    if (p > 0.0) {
      final openProg = (p / pOpenEnd).clamp(0.0, 1.0);
      path.addRect(Rect.fromLTWH(
        absoluteLeft,
        absoluteTop,
        absoluteWidth * 0.08,
        absoluteHeight * openProg,
      ));
    }

    // 2. Cellules ligne par ligne
    if (p > pOpenEnd) {
      final cellsProgress = ((p - pOpenEnd) / (pCloseStart - pOpenEnd)).clamp(0.0, 1.0);
      final totalCells = rows * cols;
      final cellW = (absoluteWidth * 0.84) / cols;
      final cellH = absoluteHeight / rows;

      final revealedCells = (totalCells * cellsProgress).floor();
      final activeCellProgress = (totalCells * cellsProgress) - revealedCells;

      int idx = 0;
      for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
          final cLeft = absoluteLeft + absoluteWidth * 0.08 + c * cellW;
          final cTop = absoluteTop + r * cellH;

          if (idx < revealedCells) {
            path.addRect(Rect.fromLTWH(cLeft, cTop, cellW, cellH));
          } else if (idx == revealedCells && activeCellProgress > 0.0) {
            path.addRect(Rect.fromLTWH(cLeft, cTop, cellW * activeCellProgress, cellH));
          }
          idx++;
        }
      }
    }

    // 3. Parenthèse fermante droite
    if (p >= pCloseStart) {
      final closeProg = ((p - pCloseStart) / (1.0 - pCloseStart)).clamp(0.0, 1.0);
      path.addRect(Rect.fromLTWH(
        absoluteLeft + absoluteWidth * 0.92,
        absoluteTop,
        absoluteWidth * 0.08,
        absoluteHeight * closeProg,
      ));
    }
  }
}

/// Zone de Racine Carrée 2D (Radical -> Contenu intérieur -> Toit)
class Sqrt2DZone extends MathZone {
  final MathZone insideZone;

  Sqrt2DZone({required this.insideZone}) : super(weight: 2.0 + insideZone.weight);

  @override
  void addClip(Path path, Size totalSize, Rect relativeBox, double localProgress) {
    final p = localProgress.clamp(0.0, 1.0);
    if (p <= 0.0) return;

    final absoluteLeft = relativeBox.left * totalSize.width;
    final absoluteTop = relativeBox.top * totalSize.height;
    final absoluteWidth = relativeBox.width * totalSize.width;
    final absoluteHeight = relativeBox.height * totalSize.height;

    const pRadicalEnd = 0.20;
    const pRoofStart = 0.85;

    // 1. Symbole radical à gauche
    if (p > 0.0) {
      final radProg = (p / pRadicalEnd).clamp(0.0, 1.0);
      path.addRect(Rect.fromLTWH(
        absoluteLeft,
        absoluteTop + absoluteHeight * (1.0 - radProg),
        absoluteWidth * 0.15,
        absoluteHeight * radProg,
      ));
    }

    // 2. Contenu intérieur
    if (p > pRadicalEnd) {
      final insideProg = ((p - pRadicalEnd) / (pRoofStart - pRadicalEnd)).clamp(0.0, 1.0);
      path.addRect(Rect.fromLTWH(
        absoluteLeft + absoluteWidth * 0.15,
        absoluteTop + absoluteHeight * 0.15,
        absoluteWidth * 0.85 * insideProg,
        absoluteHeight * 0.85,
      ));
    }

    // 3. Toit supérieur horizontal
    if (p >= pRoofStart) {
      final roofProg = ((p - pRoofStart) / (1.0 - pRoofStart)).clamp(0.0, 1.0);
      path.addRect(Rect.fromLTWH(
        absoluteLeft + absoluteWidth * 0.15,
        absoluteTop,
        absoluteWidth * 0.85 * roofProg,
        absoluteHeight * 0.15,
      ));
    }
  }
}

/// Analyseur qui convertit une formule LaTeX en arbre de zones spatiales 2D
class MathZoneAnalyzer {
  static MathZone buildZone(String latex) {
    final trimmed = latex.trim();
    if (trimmed.isEmpty) return LinearSegmentZone(weight: 1.0);

    // Détection de fraction dans l'expression (ex: x_G = \dfrac{num}{den})
    final fracMatch = RegExp(r'\\(dfrac|frac|tfrac|cfrac)\{').firstMatch(trimmed);
    if (fracMatch != null) {
      final cmdStart = fracMatch.start;
      final prefix = trimmed.substring(0, cmdStart).trim();
      final afterCmd = trimmed.substring(fracMatch.end - 1); // commence par '{'

      final numEnd = _findMatchingBrace(afterCmd, 0);
      if (numEnd != -1) {
        final numerator = afterCmd.substring(1, numEnd);
        int j = numEnd + 1;
        while (j < afterCmd.length && afterCmd[j] == ' ') j++;
        if (j < afterCmd.length && afterCmd[j] == '{') {
          final denEnd = _findMatchingBrace(afterCmd, j);
          if (denEnd != -1) {
            final denominator = afterCmd.substring(j + 1, denEnd);
            final suffix = afterCmd.substring(denEnd + 1).trim();

            final numZone = buildZone(numerator);
            final denZone = buildZone(denominator);
            final fracZone = Fraction2DZone(numeratorZone: numZone, denominatorZone: denZone);

            final parts = <MathZone>[];
            final widthRatios = <double>[];

            final wPrefix = prefix.isNotEmpty ? prefix.length.toDouble() : 0.0;
            final wFrac = fracZone.weight;
            final wSuffix = suffix.isNotEmpty ? suffix.length.toDouble() : 0.0;
            final totalCharLen = (wPrefix + wFrac + wSuffix).clamp(1.0, 1000.0);

            if (prefix.isNotEmpty) {
              parts.add(LinearSegmentZone(weight: wPrefix));
              widthRatios.add(wPrefix / totalCharLen);
            }

            parts.add(fracZone);
            widthRatios.add(wFrac / totalCharLen);

            if (suffix.isNotEmpty) {
              parts.add(buildZone(suffix));
              widthRatios.add(wSuffix / totalCharLen);
            }

            if (parts.length == 1) return parts.first;
            return CompositeSequenceZone(children: parts, widthRatios: widthRatios);
          }
        }
      }
    }

    // Détection de Matrice
    final matrixMatch = RegExp(r'\\begin\{(pmatrix|bmatrix|matrix|vmatrix|Bmatrix)\}([\s\S]*?)\\end\{\1\}').firstMatch(trimmed);
    if (matrixMatch != null) {
      final prefix = trimmed.substring(0, matrixMatch.start).trim();
      final matrixBody = matrixMatch.group(2)!;
      final suffix = trimmed.substring(matrixMatch.end).trim();

      final rows = matrixBody.split(RegExp(r'\\\\'));
      final cellZones = <MathZone>[];
      int rowCount = rows.length;
      int colCount = 1;

      for (final r in rows) {
        final cells = r.split('&');
        colCount = colCount > cells.length ? colCount : cells.length;
        for (final c in cells) {
          cellZones.add(buildZone(c.trim()));
        }
      }

      final matrixZone = Matrix2DZone(rows: rowCount, cols: colCount, cellZones: cellZones);
      final parts = <MathZone>[];
      final widthRatios = <double>[];

      final wPrefix = prefix.isNotEmpty ? prefix.length.toDouble() : 0.0;
      final wMat = matrixZone.weight;
      final wSuffix = suffix.isNotEmpty ? suffix.length.toDouble() : 0.0;
      final total = wPrefix + wMat + wSuffix;

      if (prefix.isNotEmpty) {
        parts.add(LinearSegmentZone(weight: wPrefix));
        widthRatios.add(wPrefix / total);
      }
      parts.add(matrixZone);
      widthRatios.add(wMat / total);
      if (suffix.isNotEmpty) {
        parts.add(buildZone(suffix));
        widthRatios.add(wSuffix / total);
      }

      if (parts.length == 1) return parts.first;
      return CompositeSequenceZone(children: parts, widthRatios: widthRatios);
    }

    // Détection de Racine Carrée
    final sqrtIdx = trimmed.indexOf(r'\sqrt');
    if (sqrtIdx != -1) {
      final prefix = trimmed.substring(0, sqrtIdx).trim();
      final afterSqrt = trimmed.substring(sqrtIdx + 5).trim();
      if (afterSqrt.startsWith('{')) {
        final endBrace = _findMatchingBrace(afterSqrt, 0);
        if (endBrace != -1) {
          final inside = afterSqrt.substring(1, endBrace);
          final suffix = afterSqrt.substring(endBrace + 1).trim();

          final sqrtZone = Sqrt2DZone(insideZone: buildZone(inside));
          final parts = <MathZone>[];
          final widthRatios = <double>[];
          final total = (prefix.length + sqrtZone.weight + suffix.length).clamp(1.0, 1000.0);

          if (prefix.isNotEmpty) {
            parts.add(LinearSegmentZone(weight: prefix.length.toDouble()));
            widthRatios.add(prefix.length / total);
          }
          parts.add(sqrtZone);
          widthRatios.add(sqrtZone.weight / total);
          if (suffix.isNotEmpty) {
            parts.add(buildZone(suffix));
            widthRatios.add(suffix.length / total);
          }

          if (parts.length == 1) return parts.first;
          return CompositeSequenceZone(children: parts, widthRatios: widthRatios);
        }
      }
    }

    // Formule Linéaire classique
    return LinearSegmentZone(weight: trimmed.length.clamp(1, 200).toDouble());
  }

  static int _findMatchingBrace(String s, int startIndex) {
    int depth = 0;
    for (int i = startIndex; i < s.length; i++) {
      if (s[i] == '{') depth++;
      if (s[i] == '}') {
        depth--;
        if (depth == 0) return i;
      }
    }
    return -1;
  }
}
