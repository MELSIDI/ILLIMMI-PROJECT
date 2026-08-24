import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Widget affichant le logo officiel ILLIMMI façonné en bâtons de craie blanche ("I L M")
/// sur le tableau vert d'ardoise.
class IllimmiChalkLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const IllimmiChalkLogo({
    super.key,
    this.width,
    this.height = 40,
    this.fit = BoxFit.contain,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.asset(
      'assets/images/illm_chalk_logo.png',
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Rendu vectoriel de secours
        return CustomPaint(
          size: Size(width ?? (height! * 2.8), height ?? 40),
          painter: const _ChalkStickVectorPainter(),
        );
      },
    );

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

/// Icône compacte du logo ILLIMMI pour les boutons, badges et puces d'en-tête
class IllimmiChalkIcon extends StatelessWidget {
  final double size;
  final Color? tint;

  const IllimmiChalkIcon({
    super.key,
    this.size = 20,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.5,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.2),
        child: Image.asset(
          'assets/images/illm_chalk_logo.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return CustomPaint(
              size: Size(size * 1.5, size),
              painter: const _ChalkStickVectorPainter(),
            );
          },
        ),
      ),
    );
  }
}

/// Peintre vectoriel réaliste des bâtons de craie blanche formant les lettres I L M
class _ChalkStickVectorPainter extends CustomPainter {
  const _ChalkStickVectorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final stickThick = h * 0.16;

    final chalkPaint = Paint()
      ..color = AppTheme.chalkWhite
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    void drawChalkStick(Rect rect, {double angle = 0, Offset? center}) {
      canvas.save();
      if (center != null && angle != 0) {
        canvas.translate(center.dx, center.dy);
        canvas.rotate(angle);
        canvas.translate(-center.dx, -center.dy);
      }
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(stickThick * 0.3));
      // Ombre
      canvas.drawRRect(rrect.shift(const Offset(1, 1.5)), shadowPaint);
      // Corps
      canvas.drawRRect(rrect, chalkPaint);
      canvas.restore();
    }

    // --- Lettre I (deux bâtons empilés à gauche) ---
    final iX = w * 0.12;
    drawChalkStick(Rect.fromLTWH(iX, h * 0.08, stickThick, h * 0.38));
    drawChalkStick(Rect.fromLTWH(iX, h * 0.52, stickThick, h * 0.38));

    // --- Lettre L (un bâton vertical + un horizontal) ---
    final lX = w * 0.38;
    drawChalkStick(Rect.fromLTWH(lX, h * 0.08, stickThick, h * 0.82));
    drawChalkStick(Rect.fromLTWH(lX, h * 0.76, w * 0.18, stickThick));

    // --- Lettre M (deux verticaux + deux obliques) ---
    final mX = w * 0.68;
    final mWidth = w * 0.26;
    drawChalkStick(Rect.fromLTWH(mX, h * 0.08, stickThick, h * 0.82));
    drawChalkStick(Rect.fromLTWH(mX + mWidth - stickThick, h * 0.08, stickThick, h * 0.82));

    // Oblique gauche M
    final diag1Center = Offset(mX + mWidth * 0.28, h * 0.38);
    drawChalkStick(
      Rect.fromCenter(center: diag1Center, width: stickThick, height: h * 0.55),
      angle: 0.55,
      center: diag1Center,
    );

    // Oblique droite M
    final diag2Center = Offset(mX + mWidth * 0.72, h * 0.38);
    drawChalkStick(
      Rect.fromCenter(center: diag2Center, width: stickThick, height: h * 0.55),
      angle: -0.55,
      center: diag2Center,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
