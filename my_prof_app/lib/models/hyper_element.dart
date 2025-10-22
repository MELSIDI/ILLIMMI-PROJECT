import 'package:flutter/material.dart';

// --- ÉLÉMENTS DE BASE ---
abstract class HyperElement {
  final int id;
  final double startTime;
  final double duration;
  HyperElement({required this.id, required this.startTime, this.duration = 0.0});
}

// --- ÉLÉMENTS DE DESSIN (STRUCTURÉS) ---
abstract class DrawElement extends HyperElement {
  final Color? color;
  final double width;
  DrawElement({required super.id, required super.startTime, super.duration, this.color, this.width = 2.5});
}

class LineElement extends DrawElement {
  final Offset from;
  final Offset to;
  LineElement({required super.id, required super.startTime, super.duration, super.color, required super.width, required this.from, required this.to});
}

class ArrowElement extends LineElement {
  ArrowElement({required super.id, required super.startTime, super.duration, super.color, required super.width, required super.from, required super.to});
}

class PathElement extends DrawElement {
  final List<Offset> points;
  PathElement({required super.id, required super.startTime, super.duration, super.color, required super.width, required this.points});
}

// NOUVEAU : Chemin courbe (Bézier)
class CurveElement extends DrawElement {
  final List<Offset> points; // Points de contrôle
  final bool smooth; // true = courbe lisse (Catmull-Rom), false = Bézier cubique
  final bool hasArrowAtEnd;
  final bool? arrowCounterClockwise; // true = sens trigo (+), false = sens horaire (-)
  
  CurveElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    required this.points,
    this.smooth = true,
    this.hasArrowAtEnd = false,
    this.arrowCounterClockwise,
  });
}

class PolygonElement extends DrawElement {
  final List<Offset> points;
  final Color? fillColor;
  PolygonElement({required super.id, required super.startTime, super.duration, super.color, required super.width, required this.points, this.fillColor});
}

class CircleElement extends DrawElement {
  final Offset center;
  final double radius;
  final Color? fillColor;
  final double? arrowAngle;
  final bool? arrowCounterClockwise; // true = sens trigo (+), false = sens horaire (-)

  CircleElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    required this.center, 
    required this.radius, 
    this.fillColor, 
    this.arrowAngle, 
    this.arrowCounterClockwise
  });
}

// NOUVEAU : Ellipse
class EllipseElement extends DrawElement {
  final Offset center;
  final double radiusX;
  final double radiusY;
  final double rotation; // Rotation en radians
  final Color? fillColor;
  final double? arrowAngle;
  final bool? arrowCounterClockwise;

  EllipseElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.color,
    required super.width,
    required this.center,
    required this.radiusX,
    required this.radiusY,
    this.rotation = 0.0,
    this.fillColor,
    this.arrowAngle,
    this.arrowCounterClockwise,
  });
}

class ArcElement extends DrawElement {
  final Offset center;
  final double radius;
  final double startAngle;
  final double sweepAngle;
  final bool hasArrowAtEnd;
  final bool? arrowCounterClockwise; // true = sens trigo (+), false = sens horaire (-)
  final Color? fillColor;

  ArcElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    required this.center, 
    required this.radius, 
    required this.startAngle, 
    required this.sweepAngle, 
    this.hasArrowAtEnd = false,
    this.arrowCounterClockwise,
    this.fillColor
  });
}

// NOUVEAU : Arc elliptique
class EllipticArcElement extends DrawElement {
  final Offset center;
  final double radiusX;
  final double radiusY;
  final double rotation;
  final double startAngle;
  final double sweepAngle;
  final bool hasArrowAtEnd;
  final bool? arrowCounterClockwise;
  final Color? fillColor;

  EllipticArcElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.color,
    required super.width,
    required this.center,
    required this.radiusX,
    required this.radiusY,
    this.rotation = 0.0,
    required this.startAngle,
    required this.sweepAngle,
    this.hasArrowAtEnd = false,
    this.arrowCounterClockwise,
    this.fillColor,
  });
}

// --- AUTRES ÉLÉMENTS ---
class TextElement extends HyperElement {
  final String content;
  final Offset position;
  TextElement({required super.id, required super.startTime, super.duration, required this.content, required this.position});
}

class PlotElement extends HyperElement {
  final Offset position;
  final String code;
  PlotElement({required super.id, required super.startTime, super.duration, required this.position, required this.code});
}

class MouseEvent extends HyperElement {
  final List<Offset> points;
  MouseEvent({required super.id, required super.startTime, super.duration, required this.points});
}

class EraseElement extends HyperElement {
  final List<int> idsToErase;
  EraseElement({required super.id, required super.startTime, super.duration, required this.idsToErase});
}

class SpeechElement extends HyperElement {
  final String text;
  SpeechElement({required super.id, required super.startTime, super.duration, required this.text});
}

// NOUVEAU : Tracé de fonction 2D et Re

class Repere2DElement extends DrawElement {
  final Offset origin;      // Position du repère sur le canvas
  final double xStart;        // Borne min de x
  final double xEnd;        // Borne max de x
  final double yStart;        // Borne min de y
  final double yEnd;        // Borne max de y
  final double scale;       // Échelle : 1 unité math = scale pixels

  Repere2DElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.color,
    super.width = 1.5,
    required this.origin,
    required this.xStart,
    required this.xEnd,
    required this.yStart,
    required this.yEnd,
    this.scale = 10.0,
  });
}

class Function2DElement extends DrawElement {
  final int repereId;       // ID du repère 2D à utiliser
  final String expression;  // Expression de la fonction (ex: "x^2", "sin(x)")

  Function2DElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.color,
    required super.width,
    required this.repereId,
    required this.expression,
  });
}