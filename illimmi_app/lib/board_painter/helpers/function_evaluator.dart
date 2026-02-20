// helpers/function_evaluator.dart
import 'dart:math' as math;

class FunctionEvaluator {
  static double evaluate(String expr, double xValue) {
    expr = expr.trim();
    
    // Remplacer x par sa valeur avec gestion des cas edge
    String replaced = expr.replaceAllMapped(
      RegExp(r'\bx\b'),
      (match) => '($xValue)'
    );
    
    // Gestion des fonctions implicites comme "2x" -> "2*x"
    replaced = _addImplicitMultiplication(replaced);
    
    try {
      return _evalExpression(replaced);
    } catch (e) {
      return double.nan;
    }
  }

  static String _addImplicitMultiplication(String expr) {
    // Ajoute * entre ) ( , chiffre ( , ) lettre, etc.
    return expr
        .replaceAllMapped(RegExp(r'(\d)(\()'), (match) => '${match.group(1)}*${match.group(2)}')
        .replaceAllMapped(RegExp(r'(\))(\d)'), (match) => '${match.group(1)}*${match.group(2)}')
        .replaceAllMapped(RegExp(r'(\))(\()'), (match) => '${match.group(1)}*${match.group(2)}')
        .replaceAllMapped(RegExp(r'(\d)([a-zA-Z])'), (match) => '${match.group(1)}*${match.group(2)}');
  }

  static double _evalExpression(String expr) {
    expr = expr.trim();
    
    // Enlever les parenthèses externes
    while (expr.startsWith('(') && expr.endsWith(')') && _matchingParen(expr, 0) == expr.length - 1) {
      expr = expr.substring(1, expr.length - 1).trim();
    }
    
    // Fonctions mathématiques
    final functionPatterns = {
      'sin': (String arg) => math.sin(_evalExpression(arg)),
      'cos': (String arg) => math.cos(_evalExpression(arg)),
      'tan': (String arg) => math.tan(_evalExpression(arg)),
      'sqrt': (String arg) => math.sqrt(_evalExpression(arg)),
      'exp': (String arg) => math.exp(_evalExpression(arg)),
      'abs': (String arg) => _evalExpression(arg).abs(),
      'ln': (String arg) => math.log(_evalExpression(arg)),
      'log': (String arg) => math.log(_evalExpression(arg)) / math.log(10),
    };

    for (final function in functionPatterns.entries) {
      if (expr.startsWith('${function.key}(')) {
        final inner = _extractFunctionArg(expr, function.key);
        return function.value(inner);
      }
    }
    
    // Constantes
    if (expr == 'pi') return math.pi;
    if (expr == 'e') return math.e;
    
    // Opérateurs binaires (priorité basse)
    int opPos = _findOperatorOutsideParens(expr, ['+', '-']);
    if (opPos != -1) {
      final left = expr.substring(0, opPos).trim();
      final right = expr.substring(opPos + 1).trim();
      final op = expr[opPos];
      
      if (op == '+') {
        return _evalExpression(left) + _evalExpression(right);
      } else {
        return _evalExpression(left) - _evalExpression(right);
      }
    }
    
    // Multiplication et division
    opPos = _findOperatorOutsideParens(expr, ['*', '/']);
    if (opPos != -1) {
      final left = expr.substring(0, opPos).trim();
      final right = expr.substring(opPos + 1).trim();
      final op = expr[opPos];
      
      if (op == '*') {
        return _evalExpression(left) * _evalExpression(right);
      } else {
        final divisor = _evalExpression(right);
        if (divisor == 0) return double.infinity;
        return _evalExpression(left) / divisor;
      }
    }
    
    // Puissance
    opPos = _findOperatorOutsideParens(expr, ['^']);
    if (opPos != -1) {
      final left = expr.substring(0, opPos).trim();
      final right = expr.substring(opPos + 1).trim();
      return math.pow(_evalExpression(left), _evalExpression(right)).toDouble();
    }
    
    // Nombre simple
    final num = double.tryParse(expr);
    if (num != null) return num;
    
    throw Exception('Expression non reconnue: "$expr"');
  }

  static String _extractFunctionArg(String expr, String funcName) {
    final start = funcName.length + 1;
    final end = _matchingParen(expr, funcName.length);
    return expr.substring(start, end);
  }

  static int _matchingParen(String expr, int openPos) {
    int level = 0;
    for (int i = openPos; i < expr.length; i++) {
      if (expr[i] == '(') level++;
      if (expr[i] == ')') {
        level--;
        if (level == 0) return i;
      }
    }
    return expr.length - 1;
  }

  static int _findOperatorOutsideParens(String expr, List<String> operators) {
    int level = 0;
    for (int i = expr.length - 1; i >= 0; i--) {
      if (expr[i] == ')') level++;
      if (expr[i] == '(') level--;
      
      if (level == 0 && operators.contains(expr[i])) {
        if (expr[i] == '-' && i == 0) continue;
        if (expr[i] == '-' && i > 0 && '(+-*/^'.contains(expr[i-1])) continue;
        
        return i;
      }
    }
    return -1;
  }
}