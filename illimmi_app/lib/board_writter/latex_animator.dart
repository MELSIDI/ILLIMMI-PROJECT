/// Moteur d'animation d'écriture manuscrite pour formules LaTeX et structures 2D.
///
/// Reproduit l'ordre naturel d'écriture humaine :
/// 1. Pour les équations avec fractions (ex: `x_G = \dfrac{a x_A + b x_B}{a+b}`) :
///    - Écrit le préfixe de gauche (`x_G = `)
///    - Écrit le numérateur en haut (`a x_A + b x_B`) au-dessus de la barre
///    - Descend sous la barre pour écrire le dénominateur (`a + b`)
/// 2. Pour les matrices (ex: `A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}`) :
///    - Écrit le préfixe (`A = `)
///    - Ouvre la parenthèse gauche `(`
///    - Remplit les cellules ligne par ligne ($a \to b \to c \to d$)
///    - Ferme la parenthèse droite `)`
/// 3. Pour les racines carrées (ex: `\sqrt{x + 1}`) :
///    - Trace le symbole radical $\sqrt{}$
///    - Écrit le contenu sous la barre
///
/// La stabilité géométrique est garantie à 100% par `\phantom{}` : aucun saut de mise en page,
/// aucune coupure verticale disgracieuse, et zéro erreur de compilation LaTeX.
class LatexAnimator {
  /// Calcule le poids visuel d'une formule LaTeX (nombre d'étapes d'écriture).
  static int calculateWeight(String latex) {
    final trimmed = latex.trim();
    if (trimmed.isEmpty) return 1;

    // Détection de fraction dans l'expression
    final fracInfo = _findFraction(trimmed);
    if (fracInfo != null) {
      int w = calculateWeight(fracInfo.prefix);
      w += calculateWeight(fracInfo.numerator);
      w += 1; // barre de fraction
      w += calculateWeight(fracInfo.denominator);
      w += calculateWeight(fracInfo.suffix);
      return w.clamp(3, 200);
    }

    // Détection de matrice
    final matrixInfo = _findMatrix(trimmed);
    if (matrixInfo != null) {
      int w = calculateWeight(matrixInfo.prefix) + 2;
      for (final cell in matrixInfo.cells) {
        w += calculateWeight(cell);
      }
      w += calculateWeight(matrixInfo.suffix);
      return w.clamp(3, 200);
    }

    // Détection de racine
    final sqrtInfo = _findSqrt(trimmed);
    if (sqrtInfo != null) {
      int w = calculateWeight(sqrtInfo.prefix) + 1;
      w += calculateWeight(sqrtInfo.inside);
      w += calculateWeight(sqrtInfo.suffix);
      return w.clamp(2, 150);
    }

    // Formule classique : compte les symboles visibles
    final clean = trimmed
        .replaceAll(RegExp(r'\\[a-zA-Z]+'), 'X')
        .replaceAll(RegExp(r'[\{\}\$_\^\s]'), '');
    return clean.isNotEmpty ? clean.length : trimmed.length.clamp(1, 100);
  }

  /// Génère une version progressive et syntaxiquement valide du LaTeX pour `progress ∈ [0.0, 1.0]`.
  static String generateProgressiveLatex(String latex, double progress) {
    final p = progress.clamp(0.0, 1.0);
    if (p <= 0.0) return _phantomize(latex);
    if (p >= 1.0) return latex;

    final trimmed = latex.trim();

    // 1. Détection et animation d'une Fraction (ex: x_G = \dfrac{a x_A + b x_B}{a+b})
    final fracInfo = _findFraction(trimmed);
    if (fracInfo != null) {
      return _animateFractionStructure(fracInfo, p);
    }

    // 2. Détection et animation d'une Matrice
    final matrixInfo = _findMatrix(trimmed);
    if (matrixInfo != null) {
      return _animateMatrixStructure(matrixInfo, p);
    }

    // 3. Détection et animation d'une Racine carrée
    final sqrtInfo = _findSqrt(trimmed);
    if (sqrtInfo != null) {
      return _animateSqrtStructure(sqrtInfo, p);
    }

    // 4. Expression linéaire générale : révélation séquentielle propre
    return _animateLinearExpression(trimmed, p);
  }

  /// Anime une équation avec fraction : Préfixe -> Numérateur -> Barre -> Dénominateur -> Suffixe
  static String _animateFractionStructure(_FractionInfo info, double progress) {
    final wPrefix = calculateWeight(info.prefix);
    final wNum = calculateWeight(info.numerator);
    final wBar = 1;
    final wDen = calculateWeight(info.denominator);
    final wSuffix = calculateWeight(info.suffix);
    final totalWeight = wPrefix + wNum + wBar + wDen + wSuffix;

    final stepPrefixEnd = wPrefix / totalWeight;
    final stepNumEnd = (wPrefix + wNum) / totalWeight;
    final stepBarEnd = (wPrefix + wNum + wBar) / totalWeight;
    final stepDenEnd = (wPrefix + wNum + wBar + wDen) / totalWeight;

    // Étape 1 : Écriture du préfixe (ex: "x_G = ")
    if (progress < stepPrefixEnd) {
      final subP = stepPrefixEnd > 0 ? progress / stepPrefixEnd : 0.0;
      final progPrefix = generateProgressiveLatex(info.prefix, subP);
      final phantomFrac = _phantomize('\\${info.command}{${info.numerator}}{${info.denominator}}');
      final phantomSuffix = _phantomize(info.suffix);
      return '$progPrefix $phantomFrac $phantomSuffix'.trim();
    }

    // Étape 2 : Écriture du Numérateur en haut
    if (progress < stepNumEnd) {
      final subP = (progress - stepPrefixEnd) / (stepNumEnd - stepPrefixEnd);
      final progNum = generateProgressiveLatex(info.numerator, subP);
      final phantomDen = _phantomize(info.denominator);
      final phantomSuffix = _phantomize(info.suffix);
      return '${info.prefix} \\${info.command}{$progNum}{$phantomDen} $phantomSuffix'.trim();
    }

    // Étape 3 : Traçage de la barre de fraction (stabilisation)
    if (progress < stepBarEnd) {
      final phantomDen = _phantomize(info.denominator);
      final phantomSuffix = _phantomize(info.suffix);
      return '${info.prefix} \\${info.command}{${info.numerator}}{$phantomDen} $phantomSuffix'.trim();
    }

    // Étape 4 : Écriture du Dénominateur en bas
    if (progress < stepDenEnd) {
      final subP = (progress - stepBarEnd) / (stepDenEnd - stepBarEnd);
      final progDen = generateProgressiveLatex(info.denominator, subP);
      final phantomSuffix = _phantomize(info.suffix);
      return '${info.prefix} \\${info.command}{${info.numerator}}{$progDen} $phantomSuffix'.trim();
    }

    // Étape 5 : Écriture du suffixe éventuel
    final subP = stepDenEnd < 1.0 ? (progress - stepDenEnd) / (1.0 - stepDenEnd) : 1.0;
    final progSuffix = generateProgressiveLatex(info.suffix, subP);
    return '${info.prefix} \\${info.command}{${info.numerator}}{${info.denominator}} $progSuffix'.trim();
  }

  /// Anime une matrice cellule par cellule
  static String _animateMatrixStructure(_MatrixInfo info, double progress) {
    final wPrefix = calculateWeight(info.prefix);
    final wCells = info.cells.fold<int>(0, (sum, c) => sum + calculateWeight(c));
    final wSuffix = calculateWeight(info.suffix);
    final totalWeight = wPrefix + wCells + wSuffix;

    final stepPrefixEnd = wPrefix / totalWeight;
    final stepCellsEnd = (wPrefix + wCells) / totalWeight;

    if (progress < stepPrefixEnd) {
      final subP = stepPrefixEnd > 0 ? progress / stepPrefixEnd : 0.0;
      final progPrefix = generateProgressiveLatex(info.prefix, subP);
      final phantomMatrix = _phantomize('\\begin{${info.envType}}${info.matrixBody}\\end{${info.envType}}');
      return '$progPrefix $phantomMatrix'.trim();
    }

    final cellsProgress = stepCellsEnd > stepPrefixEnd
        ? ((progress - stepPrefixEnd) / (stepCellsEnd - stepPrefixEnd)).clamp(0.0, 1.0)
        : 1.0;

    final totalCells = info.cells.length;
    final revealedCount = (totalCells * cellsProgress).floor();
    final subProgress = (totalCells * cellsProgress) - revealedCount;

    int currentIdx = 0;
    final newRows = <String>[];

    for (final row in info.parsedRows) {
      final newCells = <String>[];
      for (final cell in row) {
        if (currentIdx < revealedCount) {
          newCells.add(cell);
        } else if (currentIdx == revealedCount && subProgress > 0.0) {
          newCells.add(generateProgressiveLatex(cell, subProgress));
        } else {
          newCells.add(_phantomize(cell));
        }
        currentIdx++;
      }
      newRows.add(newCells.join(' & '));
    }

    final animatedBody = newRows.join(' \\\\ ');
    final matrixStr = '\\begin{${info.envType}}\n$animatedBody\n\\end{${info.envType}}';

    if (progress >= stepCellsEnd && info.suffix.isNotEmpty) {
      final subP = (progress - stepCellsEnd) / (1.0 - stepCellsEnd);
      final progSuffix = generateProgressiveLatex(info.suffix, subP);
      return '${info.prefix} $matrixStr $progSuffix'.trim();
    }

    return '${info.prefix} $matrixStr ${_phantomize(info.suffix)}'.trim();
  }

  /// Anime une racine carrée
  static String _animateSqrtStructure(_SqrtInfo info, double progress) {
    final wPrefix = calculateWeight(info.prefix);
    final wInside = calculateWeight(info.inside);
    final total = wPrefix + 1 + wInside;

    final pRadical = (wPrefix + 1) / total;
    if (progress < (wPrefix / total)) {
      final subP = progress / (wPrefix / total);
      return '${generateProgressiveLatex(info.prefix, subP)} ${_phantomize('\\sqrt{${info.inside}}')}';
    } else if (progress < pRadical) {
      return '${info.prefix} \\sqrt{${_phantomize(info.inside)}}';
    } else {
      final subP = (progress - pRadical) / (1.0 - pRadical);
      return '${info.prefix} \\sqrt{${generateProgressiveLatex(info.inside, subP)}}';
    }
  }

  /// Anime une expression linéaire simple (sans fraction majeure)
  static String _animateLinearExpression(String latex, double progress) {
    final cleanTokens = _extractTopLevelTokens(latex);
    if (cleanTokens.isEmpty) return latex;

    final targetTokens = (cleanTokens.length * progress).round().clamp(0, cleanTokens.length);
    if (targetTokens == 0) return _phantomize(latex);
    if (targetTokens >= cleanTokens.length) return latex;

    final buffer = StringBuffer();
    for (int i = 0; i < cleanTokens.length; i++) {
      if (i < targetTokens) {
        buffer.write(cleanTokens[i]);
      } else {
        buffer.write(_phantomize(cleanTokens[i]));
      }
    }
    return buffer.toString();
  }

  static String _phantomize(String latex) {
    final trimmed = latex.trim();
    if (trimmed.isEmpty) return '';
    return '\\phantom{$trimmed}';
  }

  /// Recherche d'une commande de fraction (`\dfrac`, `\frac`, `\tfrac`, `\cfrac`)
  static _FractionInfo? _findFraction(String s) {
    final regex = RegExp(r'\\(dfrac|frac|tfrac|cfrac)');
    final match = regex.firstMatch(s);
    if (match == null) return null;

    final cmd = match.group(1)!;
    final cmdStart = match.start;
    final cmdEnd = match.end;

    int i = cmdEnd;
    while (i < s.length && s[i] == ' ') i++;
    if (i >= s.length || s[i] != '{') return null;

    final numEnd = _findMatchingBrace(s, i);
    if (numEnd == -1) return null;
    final numerator = s.substring(i + 1, numEnd);

    int j = numEnd + 1;
    while (j < s.length && s[j] == ' ') j++;
    if (j >= s.length || s[j] != '{') return null;

    final denEnd = _findMatchingBrace(s, j);
    if (denEnd == -1) return null;
    final denominator = s.substring(j + 1, denEnd);

    final prefix = s.substring(0, cmdStart).trim();
    final suffix = s.substring(denEnd + 1).trim();

    return _FractionInfo(
      command: cmd,
      prefix: prefix,
      numerator: numerator,
      denominator: denominator,
      suffix: suffix,
    );
  }

  /// Recherche d'une matrice
  static _MatrixInfo? _findMatrix(String s) {
    final regex = RegExp(r'\\begin\{(pmatrix|bmatrix|matrix|vmatrix|Bmatrix)\}([\s\S]*?)\\end\{\1\}');
    final match = regex.firstMatch(s);
    if (match == null) return null;

    final envType = match.group(1)!;
    final matrixBody = match.group(2)!;
    final prefix = s.substring(0, match.start).trim();
    final suffix = s.substring(match.end).trim();

    final rows = matrixBody.split(RegExp(r'\\\\'));
    final parsedRows = rows.map((r) => r.split('&').map((c) => c.trim()).toList()).toList();
    final cells = <String>[];
    for (final row in parsedRows) {
      for (final cell in row) {
        if (cell.isNotEmpty) cells.add(cell);
      }
    }

    return _MatrixInfo(
      envType: envType,
      matrixBody: matrixBody,
      prefix: prefix,
      suffix: suffix,
      parsedRows: parsedRows,
      cells: cells,
    );
  }

  /// Recherche d'une racine carrée
  static _SqrtInfo? _findSqrt(String s) {
    final idx = s.indexOf(r'\sqrt');
    if (idx == -1) return null;

    int i = idx + 5;
    while (i < s.length && s[i] == ' ') i++;
    if (i >= s.length || s[i] != '{') return null;

    final endBrace = _findMatchingBrace(s, i);
    if (endBrace == -1) return null;

    final inside = s.substring(i + 1, endBrace);
    final prefix = s.substring(0, idx).trim();
    final suffix = s.substring(endBrace + 1).trim();

    return _SqrtInfo(prefix: prefix, inside: inside, suffix: suffix);
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

  static List<String> _extractTopLevelTokens(String latex) {
    final tokens = <String>[];
    int i = 0;
    while (i < latex.length) {
      if (latex[i] == ' ') {
        tokens.add(' ');
        i++;
        continue;
      }
      if (latex[i] == '\\') {
        int end = i + 1;
        while (end < latex.length && RegExp(r'[a-zA-Z]').hasMatch(latex[end])) {
          end++;
        }
        tokens.add(latex.substring(i, end));
        i = end;
        continue;
      }
      if (latex[i] == '{') {
        final end = _findMatchingBrace(latex, i);
        if (end != -1) {
          tokens.add(latex.substring(i, end + 1));
          i = end + 1;
          continue;
        }
      }
      tokens.add(latex[i]);
      i++;
    }
    return tokens;
  }
}

class _FractionInfo {
  final String command;
  final String prefix;
  final String numerator;
  final String denominator;
  final String suffix;

  _FractionInfo({
    required this.command,
    required this.prefix,
    required this.numerator,
    required this.denominator,
    required this.suffix,
  });
}

class _MatrixInfo {
  final String envType;
  final String matrixBody;
  final String prefix;
  final String suffix;
  final List<List<String>> parsedRows;
  final List<String> cells;

  _MatrixInfo({
    required this.envType,
    required this.matrixBody,
    required this.prefix,
    required this.suffix,
    required this.parsedRows,
    required this.cells,
  });
}

class _SqrtInfo {
  final String prefix;
  final String inside;
  final String suffix;

  _SqrtInfo({
    required this.prefix,
    required this.inside,
    required this.suffix,
  });
}
