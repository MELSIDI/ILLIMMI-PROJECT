import 'package:flutter/material.dart';

import '../board_painter/board_painter.dart';
import '../board_writter/latex_widget.dart';
import '../models/basic_elements/mouse_event_element.dart';
import '../models/basic_elements/text_element.dart';
import '../models/hyper_element.dart';
import '../theme/app_theme.dart';
import '../theme/board_theme.dart';
import '../widgets/chalkboard_frame.dart';

/// Reproduit, pour un instant de capture figé, la composition statique de
/// `CoursePlayer._buildWhiteboardContent` (illimmi_app/lib/player/course_player.dart)
/// — mêmes couches (BoardPainter pour les formes, LatexWidget positionné pour
/// le texte, icône pour le curseur souris), sans `AnimationController` : tous
/// les éléments sont déjà dans leur état final (voir "Décisions" dans
/// world-model-visual-feedback.md — une capture montre le tableau réglé, pas
/// une frame d'animation).
///
/// `PlotElement` n'apparaît jamais dans [elements] : le contrat JSON envoyé
/// par `generation-orchestrator` ne le sérialise pas (rendu webview hors
/// scope de cette vérification visuelle).
Widget buildCaptureWidget({
  required List<HyperElement> elements,
  required double renderWidth,
  required double renderHeight,
  required Key repaintBoundaryKey,
  BoardTheme theme = BoardTheme.green,
  Color? defaultDrawColor,
}) {
  final effectiveTheme = theme;
  final effectiveDrawColor = defaultDrawColor ?? effectiveTheme.defaultDrawColor;

  const aspectRatio = 16.0 / 9.0;
  const referenceWidth = 100.0 * aspectRatio;
  const referenceHeight = 100.0;

  final scaleX = renderWidth / referenceWidth;
  final scaleY = renderHeight / referenceHeight;
  final uniformScale = scaleX < scaleY ? scaleX : scaleY;
  final offsetX = (renderWidth - referenceWidth * uniformScale) / 2;
  final offsetY = (renderHeight - referenceHeight * uniformScale) / 2;
  final scaledFontSize = (uniformScale * 3.333).clamp(9.0, 72.0);
  final cursorSize = (24.0 * (uniformScale / 7.2)).clamp(12.0, 48.0);
  final cursorHalf = cursorSize / 2;

  final textWidgets = elements.whereType<TextElement>().map((element) {
    final x = element.position.dx * uniformScale + offsetX;
    final y = element.position.dy * uniformScale + offsetY;
    return Positioned(
      left: x,
      top: y,
      child: LatexWidget(
        content: element.content,
        fontSize: scaledFontSize,
        color: effectiveDrawColor,
        progress: 1.0,
      ),
    );
  });

  final mouseWidgets = elements.whereType<MouseEvent>().where((e) => e.points.isNotEmpty).map((
    element,
  ) {
    final position = element.points.last;
    final x = position.dx * uniformScale + offsetX;
    final y = position.dy * uniformScale + offsetY;
    return Positioned(
      left: x - cursorHalf,
      top: y - cursorHalf,
      child: Icon(Icons.circle, color: Colors.redAccent, size: cursorSize),
    );
  });

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: RepaintBoundary(
        key: repaintBoundaryKey,
        child: SizedBox(
          width: renderWidth,
          height: renderHeight,
          child: Container(
            color: effectiveTheme.backgroundColor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: ChalkboardBackground(theme: effectiveTheme),
                ),
                Positioned.fill(
                  child: CustomPaint(
                    size: Size(renderWidth, renderHeight),
                    painter: BoardPainter(
                      allElements: elements,
                      currentTime: 0,
                      defaultColor: effectiveDrawColor,
                      isStatic: true,
                    ),
                  ),
                ),
                ...textWidgets,
                ...mouseWidgets,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
