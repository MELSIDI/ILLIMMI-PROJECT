/// Remplaçants minimaux, sans dépendance Flutter, pour les deux seuls types
/// `dart:ui`/Flutter utilisés par le parser Hypercourse (`Color`, `Offset`)
/// — `package:flutter/material.dart` importe `dart:ui`, indisponible dans un
/// process `dart run` pur (ce service n'a aucun besoin de rendu : il ne fait
/// que valider qu'un script généré parse correctement).
///
/// Seule l'API réellement utilisée par le parser est reproduite :
/// `Color.fromRGBO(r, g, b, opacity)` et le constructeur positionnel
/// `Offset(dx, dy)`.
class Color {
  final int red;
  final int green;
  final int blue;
  final double opacity;

  const Color.fromRGBO(this.red, this.green, this.blue, this.opacity);
}

class Offset {
  final double dx;
  final double dy;

  const Offset(this.dx, this.dy);
}
