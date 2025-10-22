import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/hyper_element.dart';

class HypercourseParser {
  final String script;
  int _position = 0;
  String _currentChar = '';
  
  HypercourseParser(this.script) {
    if (script.isNotEmpty) {
      _currentChar = script[0];
    }
  }

  List<HyperElement> parse() {
    List<HyperElement> elements = [];
    
    _skipWhitespaceAndComments();
    
    if (_match('hypergeneration')) {
      _skipWhitespace();
      _parseString();
      _skipWhitespace();
      _expect('{');
      _skipWhitespaceAndComments();
      
      while (_currentChar != '}' && _currentChar.isNotEmpty) {
        var element = _parseCommand();
        if (element != null) {
          elements.add(element);
        }
        _skipWhitespaceAndComments();
      }
      
      _expect('}');
    }
    
    print('📋 Elements parsés: ${elements.length}');
    for (var el in elements) {
      print('  - ${el.runtimeType} id=${el.id}');
    }
    
    return elements;
  }

  HyperElement? _parseCommand() {
    _skipWhitespaceAndComments();
    
    if (_match('text')) {
      return _parseText();
    } else if (_match('draw')) {
      return _parseDraw();
    } else if (_match('plot')) {
      return _parsePlot();
    } else if (_match('erase')) {
      return _parseErase();
    } else if (_match('speech')) {
      return _parseSpeech();
    } else if (_match('mouse')) {
      return _parseMouse();
    }
    
    return null;
  }

  HyperElement _parseDraw() {
    _skipWhitespace();
    
    if (_match('2drep')) {
      return _parseDraw2DRep();
    } else if (_match('2dfunc')) {
      return _parseDraw2DFunc();
    } else if (_match('line')) {
      return _parseDrawLine(false);
    } else if (_match('arrow')) {
      return _parseDrawLine(true);
    } else if (_match('path')) {
      return _parseDrawPath();
    } else if (_match('curve')) {
      return _parseDrawCurve();
    } else if (_match('polygone')) {
      return _parseDrawPolygon();
    } else if (_match('elliptic_arc')) {
      return _parseDrawEllipticArc();
    } else if (_match('ellipse')) {
      return _parseDrawEllipse();
    } else if (_match('circle')) {
      return _parseDrawCircle();
    } else if (_match('arc')) {
      return _parseDrawArc();
    }
    
    throw Exception('Commande draw inconnue à la position $_position');
  }

  // === PARSE 2D REPÈRE ===
  Repere2DElement _parseDraw2DRep() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Offset origin = const Offset(88.89, 50); // Centre par défaut
    Color? color;
    double width = 1.5;
    double scale = 1.0;
    double xMin = -10;
    double xMax = 10;
    double yMin = -10;
    double yMax = 10;
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('at')) {
        origin = _parsePoint();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('scale')) {
        _skipWhitespace();
        _expect('=');
        _skipWhitespace();
        scale = _parseNumber();
      } else if (_match('x_range')) {
        _skipWhitespace();
        _expect('=');
        _skipWhitespace();
        _expect('[');
        _skipWhitespace();
        xMin = _parseNumber();
        _skipWhitespace();
        _expect(',');
        _skipWhitespace();
        xMax = _parseNumber();
        _skipWhitespace();
        _expect(']');
      } else if (_match('y_range')) {
        _skipWhitespace();
        _expect('=');
        _skipWhitespace();
        _expect('[');
        _skipWhitespace();
        yMin = _parseNumber();
        _skipWhitespace();
        _expect(',');
        _skipWhitespace();
        yMax = _parseNumber();
        _skipWhitespace();
        _expect(']');
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return Repere2DElement(
      id: id,
      startTime: startTime,
      duration: duration,
      origin: origin,
      xStart: xMin,
      xEnd: xMax,
      yStart: yMin,
      yEnd: yMax,
      scale: scale,
      color: color,
      width: width,
    );
  }

  // === FONCTION 2D ===
  Function2DElement _parseDraw2DFunc() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    double width = 2.5;
    int repereId = -1;
    String expression = '';
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('at')) {
        _skipWhitespace();
        repereId = _parseNumber().toInt();
      } else if (_match('y')) {
        _skipWhitespace();
        _expect('=');
        _skipWhitespace();
        expression = _parseExpression();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    if (repereId == -1) {
      throw Exception('2dfunc id $id: manque "at <id_repere>"');
    }
    
    if (expression.isEmpty) {
      throw Exception('2dfunc id $id: manque "y = <expression>"');
    }
    
    return Function2DElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      repereId: repereId,
      expression: expression,
    );
  }

  // === AUTRES MÉTHODES ===
  
  TextElement _parseText() {
    _skipWhitespace();
    
    int id = _parseId();
    Offset? position;
    double startTime = 0;
    double duration = 0;
    String content = '';
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('at')) {
        position = _parsePoint();
      } else if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_checkQuotes()) {
        content = _parseLatexString();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return TextElement(
      id: id,
      startTime: startTime,
      duration: duration,
      content: content,
      position: position ?? const Offset(0, 0),
    );
  }

  HyperElement _parseDrawLine(bool isArrow) {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    double width = 2.5;
    List<Offset> points = [];
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('at')) {
        points = _parsePointList();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    if (points.length < 2) {
      throw Exception('Une ligne nécessite au moins 2 points');
    }
    
    if (isArrow) {
      return ArrowElement(
        id: id,
        startTime: startTime,
        duration: duration,
        color: color,
        width: width,
        from: points[0],
        to: points[1],
      );
    } else {
      return LineElement(
        id: id,
        startTime: startTime,
        duration: duration,
        color: color,
        width: width,
        from: points[0],
        to: points[1],
      );
    }
  }

  PathElement _parseDrawPath() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    double width = 2.5;
    List<Offset> points = [];
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('at')) {
        points = _parsePointList();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return PathElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      points: points,
    );
  }

  CurveElement _parseDrawCurve() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    double width = 2.5;
    List<Offset> points = [];
    bool smooth = true;
    bool hasArrowAtEnd = false;
    bool? arrowCounterClockwise;
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('smooth')) {
        smooth = true;
      } else if (_match('bezier')) {
        smooth = false;
      } else if (_match('at')) {
        points = _parsePointList();
      } else if (_match('with')) {
        _skipWhitespace();
        if (_currentChar == '+') {
          arrowCounterClockwise = true;
          _advance();
        } else if (_currentChar == '-') {
          arrowCounterClockwise = false;
          _advance();
        }
        _match('arrow');
        _skipWhitespace();
        _match('at');
        _skipWhitespace();
        _match('end');
        hasArrowAtEnd = true;
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return CurveElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      points: points,
      smooth: smooth,
      hasArrowAtEnd: hasArrowAtEnd,
      arrowCounterClockwise: arrowCounterClockwise,
    );
  }

  PolygonElement _parseDrawPolygon() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    Color? fillColor;
    double width = 2.5;
    List<Offset> points = [];
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('fillcolor')) {
        fillColor = _parseColor();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('at')) {
        points = _parsePointList();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return PolygonElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      points: points,
      fillColor: fillColor,
    );
  }

  CircleElement _parseDrawCircle() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    Color? fillColor;
    double width = 2.5;
    double radius = 0;
    Offset center = const Offset(0, 0);
    double? arrowAngle;
    bool? arrowCounterClockwise;
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('fillcolor')) {
        fillColor = _parseColor();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('radius')) {
        radius = _parseNumber();
      } else if (_match('at')) {
        center = _parsePoint();
      } else if (_match('with')) {
        _skipWhitespace();
        if (_currentChar == '+') {
          arrowCounterClockwise = true;
          _advance();
        } else if (_currentChar == '-') {
          arrowCounterClockwise = false;
          _advance();
        }
        _match('arrow');
        _skipWhitespace();
        _match('on');
        _skipWhitespace();
        arrowAngle = _parseNumber();
        _match('deg');
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return CircleElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      center: center,
      radius: radius,
      fillColor: fillColor,
      arrowAngle: arrowAngle,
      arrowCounterClockwise: arrowCounterClockwise,
    );
  }

  EllipseElement _parseDrawEllipse() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    Color? fillColor;
    double width = 2.5;
    double radiusX = 0;
    double radiusY = 0;
    double rotation = 0;
    Offset center = const Offset(0, 0);
    double? arrowAngle;
    bool? arrowCounterClockwise;
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('fillcolor')) {
        fillColor = _parseColor();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('radiusX')) {
        radiusX = _parseNumber();
      } else if (_match('radiusY')) {
        radiusY = _parseNumber();
      } else if (_match('rotation')) {
        rotation = _parseNumber() * math.pi / 180;
      } else if (_match('at')) {
        center = _parsePoint();
      } else if (_match('with')) {
        _skipWhitespace();
        if (_currentChar == '+') {
          arrowCounterClockwise = true;
          _advance();
        } else if (_currentChar == '-') {
          arrowCounterClockwise = false;
          _advance();
        }
        _match('arrow');
        _skipWhitespace();
        _match('on');
        _skipWhitespace();
        arrowAngle = _parseNumber();
        _match('deg');
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return EllipseElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      center: center,
      radiusX: radiusX,
      radiusY: radiusY,
      rotation: rotation,
      fillColor: fillColor,
      arrowAngle: arrowAngle,
      arrowCounterClockwise: arrowCounterClockwise,
    );
  }

  ArcElement _parseDrawArc() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    Color? fillColor;
    double width = 2.5;
    double radius = 0;
    Offset center = const Offset(0, 0);
    double startAngle = 0;
    double endAngle = 0;
    bool hasArrowAtEnd = false;
    bool? arrowCounterClockwise;
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('fillcolor')) {
        fillColor = _parseColor();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('radius')) {
        radius = _parseNumber();
      } else if (_match('at')) {
        center = _parsePoint();
      } else if (_match('from')) {
        startAngle = _parseNumber();
        _match('deg');
      } else if (_match('to')) {
        endAngle = _parseNumber();
        _match('deg');
      } else if (_match('with')) {
        _skipWhitespace();
        if (_currentChar == '+') {
          arrowCounterClockwise = true;
          _advance();
        } else if (_currentChar == '-') {
          arrowCounterClockwise = false;
          _advance();
        }
        _match('arrow');
        _skipWhitespace();
        _match('at');
        _skipWhitespace();
        _match('end');
        hasArrowAtEnd = true;
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    double sweepAngle = (endAngle - startAngle) * math.pi / 180;
    startAngle = startAngle * math.pi / 180;
    
    return ArcElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      center: center,
      radius: radius,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      hasArrowAtEnd: hasArrowAtEnd,
      arrowCounterClockwise: arrowCounterClockwise,
      fillColor: fillColor,
    );
  }

  EllipticArcElement _parseDrawEllipticArc() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Color? color;
    Color? fillColor;
    double width = 2.5;
    double radiusX = 0;
    double radiusY = 0;
    double rotation = 0;
    Offset center = const Offset(0, 0);
    double startAngle = 0;
    double endAngle = 0;
    bool hasArrowAtEnd = false;
    bool? arrowCounterClockwise;
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('fillcolor')) {
        fillColor = _parseColor();
      } else if (_match('color')) {
        color = _parseColor();
      } else if (_match('width')) {
        width = _parseNumber();
      } else if (_match('radiusX')) {
        radiusX = _parseNumber();
      } else if (_match('radiusY')) {
        radiusY = _parseNumber();
      } else if (_match('rotation')) {
        rotation = _parseNumber() * math.pi / 180;
      } else if (_match('at')) {
        center = _parsePoint();
      } else if (_match('from')) {
        startAngle = _parseNumber();
        _match('deg');
      } else if (_match('to')) {
        endAngle = _parseNumber();
        _match('deg');
      } else if (_match('with')) {
        _skipWhitespace();
        if (_currentChar == '+') {
          arrowCounterClockwise = true;
          _advance();
        } else if (_currentChar == '-') {
          arrowCounterClockwise = false;
          _advance();
        }
        _match('arrow');
        _skipWhitespace();
        _match('at');
        _skipWhitespace();
        _match('end');
        hasArrowAtEnd = true;
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    double sweepAngle = (endAngle - startAngle) * math.pi / 180;
    startAngle = startAngle * math.pi / 180;
    
    return EllipticArcElement(
      id: id,
      startTime: startTime,
      duration: duration,
      color: color,
      width: width,
      center: center,
      radiusX: radiusX,
      radiusY: radiusY,
      rotation: rotation,
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      hasArrowAtEnd: hasArrowAtEnd,
      arrowCounterClockwise: arrowCounterClockwise,
      fillColor: fillColor,
    );
  }

  PlotElement _parsePlot() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    Offset position = const Offset(0, 0);
    String code = '';
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('at')) {
        position = _parsePoint();
      } else if (_match('code')) {
        _skipWhitespace();
        _match('python');
        _skipWhitespace();
        code = _parseLatexString();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return PlotElement(
      id: id,
      startTime: startTime,
      duration: duration,
      position: position,
      code: code,
    );
  }

  EraseElement _parseErase() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    List<int> idsToErase = [];
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('at')) {
        idsToErase = _parseIdList();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return EraseElement(
      id: id,
      startTime: startTime,
      duration: duration,
      idsToErase: idsToErase,
    );
  }

  SpeechElement _parseSpeech() {
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    String text = '';
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_currentChar == '"') {
        text = _parseString();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return SpeechElement(
      id: id,
      startTime: startTime,
      duration: duration,
      text: text,
    );
  }

  MouseEvent _parseMouse() {
    _skipWhitespace();
    _match('move');
    _skipWhitespace();
    
    int id = _parseId();
    double startTime = 0;
    double duration = 0;
    List<Offset> points = [];
    
    while (!_check(';')) {
      _skipWhitespace();
      
      if (_match('start')) {
        startTime = _parseTime();
      } else if (_match('for')) {
        duration = _parseTime();
      } else if (_match('at')) {
        points = _parsePointList();
      } else {
        _advance();
      }
    }
    
    _expect(';');
    
    return MouseEvent(
      id: id,
      startTime: startTime,
      duration: duration,
      points: points,
    );
  }

  String _parseExpression() {
    String expr = '';
    int parentheses = 0;
    
    while (_currentChar.isNotEmpty && (_currentChar != ';' || parentheses > 0)) {
      if (_currentChar == '(') parentheses++;
      if (_currentChar == ')') parentheses--;
      
      if (_currentChar == ';' && parentheses == 0) break;
      if (_currentChar == ',' && parentheses == 0) break;
      
      expr += _currentChar;
      _advance();
    }
    
    return expr.trim();
  }

  // === UTILITAIRES ===
  
  int _parseId() {
    _skipWhitespace();
    _expect('id');
    _skipWhitespace();
    return _parseNumber().toInt();
  }

  double _parseTime() {
    _skipWhitespace();
    double time = _parseNumber();
    _match('s');
    return time;
  }

  double _parseNumber() {
    _skipWhitespace();
    String numStr = '';
    
    if (_currentChar == '-' || _currentChar == '+') {
      numStr += _currentChar;
      _advance();
    }
    
    while (_isDigit(_currentChar) || _currentChar == '.') {
      numStr += _currentChar;
      _advance();
    }
    
    return double.tryParse(numStr) ?? 0;
  }

  Offset _parsePoint() {
    _skipWhitespace();
    _expect('(');
    _skipWhitespace();
    
    double x = _parseNumber();
    _skipWhitespace();
    _expect(',');
    _skipWhitespace();
    double y = _parseNumber();
    _skipWhitespace();
    _expect(')');
    
    return Offset(x, y);
  }

  List<Offset> _parsePointList() {
    List<Offset> points = [];
    _skipWhitespace();
    _expect('[');
    _skipWhitespace();
    
    while (!_check(']')) {
      points.add(_parsePoint());
      _skipWhitespace();
      if (_currentChar == ',') {
        _advance();
        _skipWhitespace();
      }
    }
    
    _expect(']');
    return points;
  }

  List<int> _parseIdList() {
    List<int> ids = [];
    _skipWhitespace();
    _expect('[');
    _skipWhitespace();
    
    while (!_check(']')) {
      ids.add(_parseNumber().toInt());
      _skipWhitespace();
      if (_currentChar == ',') {
        _advance();
        _skipWhitespace();
      }
    }
    
    _expect(']');
    return ids;
  }

  Color _parseColor() {
    _skipWhitespace();
    _expect('(');
    _skipWhitespace();
    
    int r = _parseNumber().toInt();
    _skipWhitespace();
    _expect(',');
    _skipWhitespace();
    
    int g = _parseNumber().toInt();
    _skipWhitespace();
    _expect(',');
    _skipWhitespace();
    
    int b = _parseNumber().toInt();
    _skipWhitespace();
    _expect(',');
    _skipWhitespace();
    
    double a = _parseNumber();
    _skipWhitespace();
    _expect(')');
    
    return Color.fromRGBO(r, g, b, a);
  }

  String _parseString() {
    _skipWhitespace();
    _expect('"');
    
    String result = '';
    while (_currentChar != '"' && _currentChar.isNotEmpty) {
      result += _currentChar;
      _advance();
    }
    
    _expect('"');
    return result;
  }

  String _parseLatexString() {
    _skipWhitespace();
    
    if (_currentChar == "'") {
      _advance();
      if (_currentChar == "'") {
        _advance();
      } else {
        throw Exception("Attendu '' pour une chaîne LaTeX");
      }
    }
    
    String result = '';
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

  bool _checkQuotes() {
    return _currentChar == "'" && _position + 1 < script.length && script[_position + 1] == "'";
  }

  void _advance() {
    _position++;
    if (_position < script.length) {
      _currentChar = script[_position];
    } else {
      _currentChar = '';
    }
  }

  bool _check(String expected) {
    _skipWhitespace();
    return _currentChar == expected;
  }

  void _expect(String expected) {
    _skipWhitespace();
    if (expected.length == 1) {
      if (_currentChar != expected) {
        throw Exception('Attendu "$expected" à la position $_position, trouvé "$_currentChar"');
      }
      _advance();
    } else {
      for (int i = 0; i < expected.length; i++) {
        if (_position + i >= script.length || script[_position + i] != expected[i]) {
          throw Exception('Attendu "$expected" à la position $_position');
        }
      }
      _position += expected.length;
      if (_position < script.length) {
        _currentChar = script[_position];
      } else {
        _currentChar = '';
      }
    }
  }

  bool _match(String keyword) {
    _skipWhitespace();
    
    for (int i = 0; i < keyword.length; i++) {
      if (_position + i >= script.length || script[_position + i] != keyword[i]) {
        return false;
      }
    }
    
    if (_position + keyword.length < script.length) {
      String nextChar = script[_position + keyword.length];
      if (_isAlphaNumeric(nextChar)) {
        return false;
      }
    }
    
    _position += keyword.length;
    if (_position < script.length) {
      _currentChar = script[_position];
    } else {
      _currentChar = '';
    }
    return true;
  }

  void _skipWhitespace() {
    while (_currentChar == ' ' || _currentChar == '\t' || _currentChar == '\n' || _currentChar == '\r') {
      _advance();
    }
  }

  void _skipWhitespaceAndComments() {
    while (true) {
      _skipWhitespace();
      
      if (_currentChar == '#') {
        while (_currentChar != '\n' && _currentChar.isNotEmpty) {
          _advance();
        }
      } else {
        break;
      }
    }
  }

  bool _isDigit(String char) {
    return char.isNotEmpty && '0123456789'.contains(char);
  }

  bool _isAlphaNumeric(String char) {
    return char.isNotEmpty && RegExp(r'[a-zA-Z0-9_]').hasMatch(char);
  }
}