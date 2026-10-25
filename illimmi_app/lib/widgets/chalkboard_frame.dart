import 'package:flutter/material.dart';
import '../theme/board_theme.dart';

/// Arrière-plan tableau vert (Chalkboard) immersif et sans bordure en bois :
/// Texture d'ardoise verte réaliste avec poussière de craie, dégradé doux et traces d'effacement.
class ChalkboardFrame extends StatelessWidget {
  final Widget child;
  final BoardTheme theme;

  const ChalkboardFrame({
    super.key,
    required this.child,
    this.theme = BoardTheme.green,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Texture de fond ardoise plein écran
        Positioned.fill(
          child: ChalkboardBackground(theme: theme),
        ),

        // 2. Contenu principal fluide
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}

/// Arrière-plan ardoise avec texture de poussière et traces de craie, adaptable au thème choisi.
class ChalkboardBackground extends StatelessWidget {
  final BoardTheme theme;

  const ChalkboardBackground({
    super.key,
    this.theme = BoardTheme.green,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: theme.hasTexture ? ChalkboardTexturePainter(smudgeColor: theme.smudgeColor) : null,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.0, -0.1),
            radius: 1.1,
            colors: theme.gradientColors,
            stops: const [0.0, 0.65, 1.0],
          ),
        ),
      ),
    );
  }
}

/// Peintre de la texture organique d'ardoise et de traces d'effaceur
class ChalkboardTexturePainter extends CustomPainter {
  final Color smudgeColor;

  const ChalkboardTexturePainter({
    this.smudgeColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    // Traces d'effacement horizontales et courbes douces
    final smudgePaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28);

    // Smudge 1 - Centre gauche
    smudgePaint.color = smudgeColor.withValues(alpha: 0.035);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.45),
        width: size.width * 0.6,
        height: size.height * 0.35,
      ),
      smudgePaint,
    );

    // Smudge 2 - Haut droite
    smudgePaint.color = smudgeColor.withValues(alpha: 0.025);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.7, size.height * 0.3),
        width: size.width * 0.5,
        height: size.height * 0.3,
      ),
      smudgePaint,
    );

    // Smudge 3 - Bas
    smudgePaint.color = smudgeColor.withValues(alpha: 0.03);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.75),
        width: size.width * 0.7,
        height: size.height * 0.25,
      ),
      smudgePaint,
    );

    // Lignes de craie estompées
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 35
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18)
      ..color = smudgeColor.withValues(alpha: 0.02);

    final path1 = Path()
      ..moveTo(size.width * 0.1, size.height * 0.25)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.2,
        size.width * 0.85,
        size.height * 0.35,
      );
    canvas.drawPath(path1, strokePaint);

    final path2 = Path()
      ..moveTo(size.width * 0.15, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.68,
        size.width * 0.9,
        size.height * 0.55,
      );
    canvas.drawPath(path2, strokePaint);

    // Vignette d'ombre intérieure subtile
    final vignettePaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          Colors.transparent,
          Colors.black.withValues(alpha: 0.2),
        ],
        stops: const [0.75, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), vignettePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

