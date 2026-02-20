// coordinate_system.dart
import 'package:flutter/material.dart';
//import 'dart:math' as math;

class CoordinateSystem {
  final Matrix4 matrix;
  final double referenceWidth;
  final double referenceHeight;
  final double uniformScale;

  CoordinateSystem(Size size)
      : referenceWidth = 100.0 * (16.0 / 9.0),
        referenceHeight = 100.0,
        uniformScale = _calculateUniformScale(size, 100.0 * (16.0 / 9.0), 100.0),
        matrix = _createTransformationMatrix(size, 100.0 * (16.0 / 9.0), 100.0);

  static double _calculateUniformScale(Size size, double refWidth, double refHeight) {
    final scaleX = size.width / refWidth;
    final scaleY = size.height / refHeight;
    return scaleX < scaleY ? scaleX : scaleY;
  }

  static Matrix4 _createTransformationMatrix(Size size, double refWidth, double refHeight) {
    final uniformScale = _calculateUniformScale(size, refWidth, refHeight);
    final offsetX = (size.width - refWidth * uniformScale) / 2;
    final offsetY = (size.height - refHeight * uniformScale) / 2;
    
    return Matrix4.identity()
      ..translate(offsetX, offsetY)
      ..scale(uniformScale, uniformScale);
  }

  Offset transformPoint(Offset point) {
    return MatrixUtils.transformPoint(matrix, point);
  }

  double transformScale(double value) {
    final sx = matrix.storage[0];
    final sy = matrix.storage[5];
    return value * ((sx + sy) / 2);
  }
}