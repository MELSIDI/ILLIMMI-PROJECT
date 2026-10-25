import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Les 9 états canoniques de Thinking Orb (Jakub Antalik / MIT).
enum ThinkingOrbState {
  working,    // Particules sur orbites inclinées (Orbits)
  searching,  // Méridien de scan balayant un globe en pointillés (Globe)
  solving,    // Bandes cubiques se désorganisant puis se résolvant (Rubik)
  listening,  // Ondulation fluide se propageant dans les anneaux (Wave)
  connecting, // Constellation connectant des nœuds et envoyant des paquets (Web)
  weaving,    // Trois brins tressés s'enroulant autour d'une sphère (Braid)
  composing,  // Écharpe multi-bandes ondulante (Ribbon)
  breathing,  // Anneau respirant en déformation continue (Ring)
  shaping,    // Morphing géométrique continu : cercle → triangle → carré (Morph)
}

/// Style de couleur pour l'ardoise ou fond clair/foncé
enum OrbColorStyle {
  chalk,      // Tons craie élégants (craie blanche, cyan & bleue pastel sur fond ardoise)
  monochrome, // Noir & blanc pur avec profondeur z-sort (style officiel thinking-orbs)
}

/// Modèle d'un point 3D projeté sur le canvas 2D
class Dot {
  final double x;
  final double y;
  final double z;
  final double r;
  final double white;
  final double a;

  const Dot({
    required this.x,
    required this.y,
    required this.z,
    required this.r,
    required this.white,
    this.a = 1.0,
  });
}

/// Modèle d'un segment de ligne projeté (utilisé par le mode connecting / web)
class OrbLine {
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double white;
  final double a;
  final double w;

  const OrbLine({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    required this.white,
    this.a = 1.0,
    required this.w,
  });
}

/// Rendu instantané complet d'une frame géométrique
class OrbFrame {
  final List<Dot> dots;
  final List<OrbLine> lines;

  const OrbFrame({
    required this.dots,
    required this.lines,
  });
}

// -----------------------------------------------------------------------------
// Moteur mathématique & Géométrique portable (Thinking Orbs Lineage)
// -----------------------------------------------------------------------------

double _hashD(double a, double b) {
  final h = math.sin(a * 12.9898 + b * 78.233) * 43758.5453;
  return h - h.floorToDouble();
}

double _vnoise(double x, double y) {
  final xi = x.floorToDouble();
  final yi = y.floorToDouble();
  double fx = x - xi;
  double fy = y - yi;
  fx = fx * fx * (3.0 - 2.0 * fx);
  fy = fy * fy * (3.0 - 2.0 * fy);
  final a = _hashD(xi, yi);
  final b = _hashD(xi + 1.0, yi);
  final c = _hashD(xi, yi + 1.0);
  final d = _hashD(xi + 1.0, yi + 1.0);
  return a + (b - a) * fx + (c - a) * fy + (a - b - c + d) * fx * fy;
}

List<double> _fibDir(int i, int n) {
  final golden = math.pi * (3.0 - math.sqrt(5.0));
  final y = 1.0 - (2.0 * (i + 0.5)) / n;
  final rad = math.sqrt(math.max(0.0, 1.0 - y * y));
  final a = i * golden;
  return [rad * math.cos(a), y, rad * math.sin(a)];
}

double _angleDelta(double a, double b) {
  return math.atan2(math.sin(a - b), math.cos(a - b));
}

double _radiusScale(double size, double pow) {
  return math.pow(size / 300.0, pow).toDouble();
}

List<double> Function(double x, double y, double z) _makeProj(
  double yaw,
  double tilt,
  double cx,
  double cy,
  double scale,
) {
  final st = math.sin(tilt);
  final ct = math.cos(tilt);
  final sy = math.sin(yaw);
  final cyw = math.cos(yaw);
  return (double x, double y, double z) {
    final x1 = x * cyw + z * sy;
    final z1 = -x * sy + z * cyw;
    final y1 = y * ct - z1 * st;
    final z2 = y * st + z1 * ct;
    return [cx + x1 * scale, cy - y1 * scale, z2];
  };
}

OrbFrame _finalizeFrame(List<Dot> dots, List<OrbLine> lines, [double rMin = 0.35]) {
  final visible = <Dot>[];
  for (final d in dots) {
    if (d.a < 0.02) continue;
    visible.add(Dot(
      x: d.x,
      y: d.y,
      z: d.z,
      r: math.max(rMin, d.r),
      white: d.white,
      a: d.a,
    ));
  }
  visible.sort((a, b) => a.z.compareTo(b.z));
  return OrbFrame(
    dots: visible,
    lines: lines.where((l) => l.a >= 0.02).toList(),
  );
}

// -----------------------------------------------------------------------------
// Les 9 Générateurs de Frames Spécifiques
// -----------------------------------------------------------------------------

OrbFrame _frameOrbits(double size, double t, bool isSmall) {
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.82;
  final pt = _makeProj(t * 0.12, 0.3, cx, cy, 1.0);
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.8 : 1.0);

  final dots = <Dot>[];
  final orbitN = isSmall ? 5 : 12;
  final ghostN = isSmall ? 18 : 38;
  final particles = isSmall ? 2 : 3;

  for (int orb = 0; orb < orbitN; orb++) {
    final h1 = _hashD(orb.toDouble(), 1.7);
    final h2 = _hashD(orb.toDouble(), 5.2);
    final h3 = _hashD(orb.toDouble(), 8.9);
    final ro = r * (0.45 + 0.52 * h1);
    final th = h1 * 2 * math.pi;
    final phi = math.acos(2.0 * h2 - 1.0);

    final nx = math.sin(phi) * math.cos(th);
    final ny = math.cos(phi);
    final nz = math.sin(phi) * math.sin(th);
    double ux = -ny;
    double uy = nx;
    const double uz = 0.0;
    final ul = math.max(1e-6, math.sqrt(ux * ux + uy * uy));
    ux /= ul;
    uy /= ul;
    final vx = ny * uz - nz * uy;
    final vy = nz * ux - nx * uz;
    final vz = nx * uy - ny * ux;
    final speed = (0.25 + 0.55 * h3) * (h3 > 0.5 ? 1.0 : -1.0);

    // Orbite fantôme
    for (int k = 0; k < ghostN; k++) {
      final a = (k / ghostN) * 2 * math.pi;
      final p = pt(
        (ux * math.cos(a) + vx * math.sin(a)) * ro,
        (uy * math.cos(a) + vy * math.sin(a)) * ro,
        (uz * math.cos(a) + vz * math.sin(a)) * ro,
      );
      final depth = (p[2] / ro + 1.0) / 2.0;
      dots.add(Dot(
        x: p[0],
        y: p[1],
        z: p[2],
        r: 0.9 * rs,
        white: 0.72,
        a: 0.5 * (0.4 + 0.6 * depth),
      ));
    }

    // Particules actives
    for (int m = 0; m < particles; m++) {
      final a = t * speed + (m / particles) * 2 * math.pi + h2 * 6.0;
      final p = pt(
        (ux * math.cos(a) + vx * math.sin(a)) * ro,
        (uy * math.cos(a) + vy * math.sin(a)) * ro,
        (uz * math.cos(a) + vz * math.sin(a)) * ro,
      );
      final depth = (p[2] / ro + 1.0) / 2.0;
      dots.add(Dot(
        x: p[0],
        y: p[1],
        z: p[2],
        r: (1.2 + 1.6 * depth) * rs,
        white: 0.3 - 0.22 * depth,
        a: 1.0,
      ));
    }
  }
  return _finalizeFrame(dots, const []);
}

OrbFrame _frameGlobe(double size, double t, bool isSmall) {
  const spin = 0.5;
  final cx = size / 2.0;
  final cy = size / 2.0;
  final radius = (size / 2.0) * 0.82;
  final tilt = 0.4 + 0.06 * math.sin(t * 0.35);
  final pt = _makeProj(t * spin, tilt, cx, cy, radius);
  final scan = t * (spin + 1.2);
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.6 : 1.0);

  final dots = <Dot>[];
  final latRings = isSmall ? 8 : 16;
  final lonDensity = isSmall ? 20 : 42;

  for (int li = 0; li <= latRings; li++) {
    final lat = -math.pi / 2.0 + (li / latRings) * math.pi;
    final cosLat = math.cos(lat);
    final sinLat = math.sin(lat);
    final lonCount = math.max(1, (cosLat.abs() * lonDensity).round());
    for (int lj = 0; lj < lonCount; lj++) {
      final lon = (lj / lonCount) * 2.0 * math.pi;
      final p = pt(cosLat * math.cos(lon), sinLat, cosLat * math.sin(lon));
      final depth = (p[2] + 1.0) / 2.0;
      final d = _angleDelta(lon + t * spin, scan);
      final boost = math.exp(-(d * d) / 0.18) * math.max(0.0, p[2]);
      dots.add(Dot(
        x: p[0],
        y: p[1],
        z: p[2],
        r: (0.6 + 1.7 * depth + 1.0 * boost) * rs,
        white: 0.62 - 0.54 * depth,
        a: 0.25 + 0.75 * math.min(1.0, boost + 0.3 * depth),
      ));
    }
  }
  return _finalizeFrame(dots, const []);
}

OrbFrame _frameWave(double size, double t, bool isSmall) {
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.874;
  final pt = _makeProj(t * 0.18, 0.38, cx, cy, 1.0);
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.6 : 1.0);

  final dots = <Dot>[];
  final rings = isSmall ? 8 : 15;
  final lonDensity = isSmall ? 20 : 40;

  for (int ri = 0; ri <= rings; ri++) {
    final lat = -math.pi / 2.0 + (ri / rings) * math.pi;
    final cosLat = math.cos(lat);
    final sinLat = math.sin(lat);
    final w = 0.62 * math.sin(t * 2.1 - ri * 0.52) + 0.38 * math.sin(t * 1.27 + ri * 0.83);
    final rr = r * (0.88 + 0.105 * w);
    final lonCount = math.max(1, (cosLat.abs() * lonDensity).round());
    for (int lj = 0; lj < lonCount; lj++) {
      final lon = (lj / lonCount) * 2.0 * math.pi;
      final p = pt(cosLat * math.cos(lon) * rr, sinLat * rr, cosLat * math.sin(lon) * rr);
      final depth = (p[2] / r + 1.0) / 2.0;
      final crest = math.max(0.0, w);
      dots.add(Dot(
        x: p[0],
        y: p[1],
        z: p[2],
        r: (0.6 + 1.7 * depth) * (1.0 + 0.4 * crest) * rs,
        white: 0.66 - 0.56 * depth - 0.1 * crest,
        a: 0.3 + 0.7 * depth,
      ));
    }
  }
  return _finalizeFrame(dots, const []);
}

OrbFrame _frameBraid(double size, double t, bool isSmall) {
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.76;
  final pt = _makeProj(t * 0.4, 0.3, cx, cy, 1.0);
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.7 : 1.0);

  final dots = <Dot>[];
  final ghostN = isSmall ? 40 : 120;
  for (int i = 0; i < ghostN; i++) {
    final d = _fibDir(i, ghostN);
    final p = pt(d[0] * r, d[1] * r, d[2] * r);
    final depth = (p[2] / r + 1.0) / 2.0;
    dots.add(Dot(x: p[0], y: p[1], z: p[2], r: 0.8 * rs, white: 0.78, a: 0.08 + 0.22 * depth));
  }

  final strandN = isSmall ? 25 : 52;
  const turns = 3.0;
  for (int s = 0; s < 3; s++) {
    final phase = (s / 3.0) * 2.0 * math.pi;
    for (int i = 0; i < strandN; i++) {
      final frac = (i / strandN + t * 0.045) % 1.0;
      final u = (frac * 2.0 - 1.0) * 0.96;
      final surf = math.sqrt(math.max(0.0, 1.0 - u * u));
      final endFade = math.min(1.0, (1.0 - u.abs()) / 0.1);
      final a = u * math.pi * turns + phase;
      final weave = 1.0 + 0.075 * math.sin(u * math.pi * turns * 2.0 + phase * 2.0 + t * 0.8);
      final rr = surf * r * weave;
      final p = pt(math.cos(a) * rr, u * r * weave, math.sin(a) * rr);
      final depth = (p[2] / r + 1.0) / 2.0;
      dots.add(Dot(
        x: p[0],
        y: p[1],
        z: p[2],
        r: (1.2 + 1.8 * depth) * rs,
        white: 0.55 - 0.45 * depth,
        a: endFade * (0.45 + 0.55 * depth),
      ));
    }
  }
  return _finalizeFrame(dots, const []);
}

OrbFrame _frameConnecting(double size, double t, bool isSmall) {
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.8;
  final pt = _makeProj(t * 0.12, 0.32, cx, cy, r);
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.6 : 1.0);

  final nodeN = isSmall ? 14 : 28;
  const thr = 0.75;
  final nodes = <List<double>>[];

  for (int i = 0; i < nodeN; i++) {
    final d = _fibDir(i, nodeN);
    final x = d[0] + 0.3 * (_vnoise(i * 0.31 + 9.0, t * 0.24) - 0.5) * 2.0;
    final y = d[1] + 0.3 * (_vnoise(i * 0.53 + 27.0, t * 0.21) - 0.5) * 2.0;
    final z = d[2] + 0.3 * (_vnoise(i * 0.77 + 55.0, t * 0.27) - 0.5) * 2.0;
    final l = math.sqrt(x * x + y * y + z * z);
    nodes.add([x / l, y / l, z / l]);
  }

  final lines = <OrbLine>[];
  final dots = <Dot>[];

  // Lignes entre voisins
  for (int i = 0; i < nodeN; i++) {
    for (int j = i + 1; j < nodeN; j++) {
      final dx = nodes[i][0] - nodes[j][0];
      final dy = nodes[i][1] - nodes[j][1];
      final dz = nodes[i][2] - nodes[j][2];
      final dist = math.sqrt(dx * dx + dy * dy + dz * dz);
      if (dist >= thr) continue;
      final p1 = pt(nodes[i][0], nodes[i][1], nodes[i][2]);
      final p2 = pt(nodes[j][0], nodes[j][1], nodes[j][2]);
      final depth = ((p1[2] + p2[2]) / 2.0 + 1.0) / 2.0;
      lines.add(OrbLine(
        x1: p1[0],
        y1: p1[1],
        x2: p2[0],
        y2: p2[1],
        white: 0.42,
        a: (1.0 - dist / thr) * (0.3 + 0.55 * depth),
        w: math.max(0.6, 0.8 * rs),
      ));
    }
  }

  // Nœuds
  for (int i = 0; i < nodeN; i++) {
    final p = pt(nodes[i][0], nodes[i][1], nodes[i][2]);
    final depth = (p[2] + 1.0) / 2.0;
    final pulse = 1.0 + 0.25 * math.sin(t * 1.4 + i * 2.7);
    dots.add(Dot(
      x: p[0],
      y: p[1],
      z: p[2],
      r: (1.4 + 1.8 * depth) * pulse * rs,
      white: 0.55 - 0.45 * depth,
      a: 0.3 + 0.7 * depth,
    ));
  }
  return _finalizeFrame(dots, lines);
}

OrbFrame _frameComposing(double size, double t, bool isSmall) {
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.78;
  final pt = _makeProj(t * 0.1, 0.3, cx, cy, 1.0);
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.7 : 1.0);

  final dots = <Dot>[];
  final ghostN = isSmall ? 35 : 100;
  for (int i = 0; i < ghostN; i++) {
    final d = _fibDir(i, ghostN);
    final p = pt(d[0] * r, d[1] * r, d[2] * r);
    final depth = (p[2] / r + 1.0) / 2.0;
    dots.add(Dot(x: p[0], y: p[1], z: p[2], r: 0.8 * rs, white: 0.78, a: 0.1 + 0.2 * depth));
  }

  final ya = t * 0.24;
  final ta = 0.55 + 0.3 * math.sin(t * 0.18);
  final ux = math.cos(ya);
  const uy = 0.0;
  final uz = math.sin(ya);
  final vx = -uz * math.sin(ta);
  final vy = math.cos(ta);
  final vz = ux * math.sin(ta);
  final nx = uy * vz - uz * vy;
  final ny = uz * vx - ux * vz;
  final nz = ux * vy - uy * vx;

  final lanes = isSmall ? 3 : 5;
  final segs = isSmall ? 35 : 75;
  for (int w = 0; w < lanes; w++) {
    final laneOff = (w - (lanes - 1) / 2.0) * 0.075;
    for (int k = 0; k < segs; k++) {
      final a = (k / segs) * 2.0 * math.pi;
      final wob = 0.16 * math.sin(a * 3.0 - t * 1.7 + w * 0.22) + 0.07 * math.sin(a * 5.0 + t * 1.1);
      final off = laneOff + wob;
      final x = ux * math.cos(a) + vx * math.sin(a) + nx * off;
      final y = uy * math.cos(a) + vy * math.sin(a) + ny * off;
      final z = uz * math.cos(a) + vz * math.sin(a) + nz * off;
      final l = math.sqrt(x * x + y * y + z * z);
      final p = pt((x / l) * r, (y / l) * r, (z / l) * r);
      final depth = (p[2] / r + 1.0) / 2.0;
      dots.add(Dot(
        x: p[0],
        y: p[1],
        z: p[2],
        r: (1.1 + 1.7 * depth) * rs,
        white: 0.52 - 0.44 * depth,
        a: 0.35 + 0.65 * depth,
      ));
    }
  }
  return _finalizeFrame(dots, const []);
}

OrbFrame _frameBreathing(double size, double t, bool isSmall) {
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.72;
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.7 : 1.0);

  final dots = <Dot>[];
  final lanes = isSmall ? 3 : 5;
  final segs = isSmall ? 35 : 72;

  for (int w = 0; w < lanes; w++) {
    final laneOff = (w - (lanes - 1) / 2.0) * 0.06;
    for (int k = 0; k < segs; k++) {
      final a = (k / segs) * 2.0 * math.pi;
      final wob = 0.14 * math.sin(a * 3.0 - t * 1.2 + w * 0.15) + 0.08 * math.sin(a * 4.0 + t * 0.8);
      final rr = r * (1.0 + wob) + laneOff * r;
      final px = cx + math.cos(a) * rr;
      final py = cy + math.sin(a) * rr;
      dots.add(Dot(
        x: px,
        y: py,
        z: math.sin(a * 2.0 + t) * 0.5,
        r: (1.0 + 0.8 * math.sin(a + t * 2.0)) * rs,
        white: 0.3 + 0.3 * math.sin(a * 2.0 - t),
        a: 0.75 + 0.25 * math.sin(a * 3.0 + t),
      ));
    }
  }
  return _finalizeFrame(dots, const []);
}

OrbFrame _frameSolving(double size, double t, bool isSmall) {
  // Mode Rubik / Solving : bandes tournantes
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.82;
  final pt = _makeProj(t * 0.55, 0.35 + 0.1 * math.sin(t * 0.9), cx, cy, r);
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.6 : 1.0);

  final dots = <Dot>[];
  final latRings = isSmall ? 7 : 14;
  final lonDensity = isSmall ? 18 : 36;
  final cycle = (t * 0.7) % 4.0;
  final twist = math.sin(cycle * math.pi) * 0.6;

  for (int li = 0; li <= latRings; li++) {
    final lat = -math.pi / 2.0 + (li / latRings) * math.pi;
    final cosLat = math.cos(lat);
    final sinLat = math.sin(lat);
    final bandTwist = (li % 3 == 0) ? twist : -twist * 0.5;
    final lonCount = math.max(1, (cosLat.abs() * lonDensity).round());
    for (int lj = 0; lj < lonCount; lj++) {
      final lon = (lj / lonCount) * 2.0 * math.pi + bandTwist;
      final p = pt(cosLat * math.cos(lon), sinLat, cosLat * math.sin(lon));
      final depth = (p[2] + 1.0) / 2.0;
      dots.add(Dot(
        x: p[0],
        y: p[1],
        z: p[2],
        r: (0.7 + 1.6 * depth) * rs,
        white: 0.55 - 0.45 * depth,
        a: 0.3 + 0.7 * depth,
      ));
    }
  }
  return _finalizeFrame(dots, const []);
}

OrbFrame _frameShaping(double size, double t, bool isSmall) {
  final cx = size / 2.0;
  final cy = size / 2.0;
  final r = (size / 2.0) * 0.75;
  final rs = _radiusScale(size, 0.6) * (isSmall ? 1.6 : 1.0);

  final dots = <Dot>[];
  final n = isSmall ? 24 : 48;
  final phase = (t * 0.5) % 3.0; // 0=cercle, 1=triangle, 2=carré
  final morphStage = phase.floor();
  final morphFrac = phase - morphStage;
  final smooth = morphFrac * morphFrac * (3.0 - 2.0 * morphFrac);

  for (int i = 0; i < n; i++) {
    final a = (i / n) * 2.0 * math.pi;
    // Cercle
    final cX = math.cos(a) * r;
    final cY = math.sin(a) * r;

    // Triangle
    final triAngle = a + math.pi / 6.0;
    final triR = r * (0.8 + 0.25 * math.cos(3.0 * triAngle));
    final tX = math.cos(a) * triR;
    final tY = math.sin(a) * triR;

    // Carré
    final sqR = r * (0.8 + 0.2 * math.cos(4.0 * a).abs());
    final sX = math.cos(a) * sqR;
    final sY = math.sin(a) * sqR;

    double px = 0;
    double py = 0;
    if (morphStage == 0) {
      px = cX + (tX - cX) * smooth;
      py = cY + (tY - cY) * smooth;
    } else if (morphStage == 1) {
      px = tX + (sX - tX) * smooth;
      py = tY + (sY - tY) * smooth;
    } else {
      px = sX + (cX - sX) * smooth;
      py = sY + (cY - sY) * smooth;
    }

    dots.add(Dot(
      x: cx + px,
      y: cy + py,
      z: 0.0,
      r: (1.2 + 0.4 * math.sin(a * 2.0 + t * 2.0)) * rs,
      white: 0.2 + 0.3 * math.sin(a + t),
      a: 0.9,
    ));
  }
  return _finalizeFrame(dots, const []);
}

// -----------------------------------------------------------------------------
// Widget ThinkingOrb
// -----------------------------------------------------------------------------

/// Widget Flutter autonome affichant un "Thinking Orb" réactif et animé.
class ThinkingOrb extends StatefulWidget {
  final ThinkingOrbState state;
  final double size;
  final double speed;
  final OrbColorStyle colorStyle;
  final bool paused;

  const ThinkingOrb({
    super.key,
    this.state = ThinkingOrbState.working,
    this.size = 64.0,
    this.speed = 1.0,
    this.colorStyle = OrbColorStyle.chalk,
    this.paused = false,
  });

  @override
  State<ThinkingOrb> createState() => _ThinkingOrbState();
}

class _ThinkingOrbState extends State<ThinkingOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    if (!widget.paused) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ThinkingOrb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.paused != oldWidget.paused) {
      if (widget.paused) {
        _controller.stop();
      } else {
        _controller.repeat();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value * 2.0 * math.pi * 5.0 * widget.speed;
          final isSmall = widget.size <= 32.0;

          OrbFrame frame;
          switch (widget.state) {
            case ThinkingOrbState.working:
              frame = _frameOrbits(widget.size, t * 1.885, isSmall);
              break;
            case ThinkingOrbState.searching:
              frame = _frameGlobe(widget.size, t * 1.5, isSmall);
              break;
            case ThinkingOrbState.solving:
              frame = _frameSolving(widget.size, t * 1.4, isSmall);
              break;
            case ThinkingOrbState.listening:
              frame = _frameWave(widget.size, t * 1.6, isSmall);
              break;
            case ThinkingOrbState.connecting:
              frame = _frameConnecting(widget.size, t * 1.4, isSmall);
              break;
            case ThinkingOrbState.weaving:
              frame = _frameBraid(widget.size, t * 1.7, isSmall);
              break;
            case ThinkingOrbState.composing:
              frame = _frameComposing(widget.size, t * 1.5, isSmall);
              break;
            case ThinkingOrbState.breathing:
              frame = _frameBreathing(widget.size, t * 1.2, isSmall);
              break;
            case ThinkingOrbState.shaping:
              frame = _frameShaping(widget.size, t * 1.3, isSmall);
              break;
          }

          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _OrbPainter(
              frame: frame,
              colorStyle: widget.colorStyle,
            ),
          );
        },
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  final OrbFrame frame;
  final OrbColorStyle colorStyle;

  _OrbPainter({
    required this.frame,
    required this.colorStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dessiner les lignes
    for (final l in frame.lines) {
      final alpha = (l.a).clamp(0.0, 1.0);
      final w = l.white.clamp(0.0, 1.0);

      Color strokeColor;
      if (colorStyle == OrbColorStyle.chalk) {
        strokeColor = AppTheme.chalkCyan.withValues(alpha: alpha * (1.0 - w * 0.4));
      } else {
        final g = ((1.0 - w) * 255).round();
        strokeColor = Color.fromARGB((alpha * 255).round(), g, g, g);
      }

      final linePaint = Paint()
        ..color = strokeColor
        ..strokeWidth = l.w
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset(l.x1, l.y1), Offset(l.x2, l.y2), linePaint);
    }

    // 2. Dessiner les points (dots) ordonnés en profondeur z
    final dotPaint = Paint()..style = PaintingStyle.fill;
    for (final d in frame.dots) {
      final alpha = (d.a).clamp(0.0, 1.0);
      final w = d.white.clamp(0.0, 1.0);

      Color dotColor;
      if (colorStyle == OrbColorStyle.chalk) {
        // En mode ardoise : blanc craie pour le premier plan, cyan/bleu subtil pour la profondeur
        final depthGlow = (1.0 - w); // 1 = très proche, 0 = lointain
        if (depthGlow > 0.6) {
          // Premier plan : craie blanc pure et nette
          dotColor = AppTheme.chalkWhite.withValues(alpha: alpha);
        } else if (depthGlow > 0.3) {
          // Plan intermédiaire : nuance craie cyan
          dotColor = AppTheme.chalkCyan.withValues(alpha: alpha * 0.9);
        } else {
          // Arrière-plan : bleu craie doux
          dotColor = AppTheme.chalkBlue.withValues(alpha: alpha * 0.65);
        }
      } else {
        // Mode monochrome classique
        final g = ((1.0 - w) * 255).round();
        dotColor = Color.fromARGB((alpha * 255).round(), g, g, g);
      }

      dotPaint.color = dotColor;
      canvas.drawCircle(Offset(d.x, d.y), d.r, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) => true;
}
