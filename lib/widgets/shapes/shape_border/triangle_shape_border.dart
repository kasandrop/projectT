import 'package:flutter/material.dart';

class TriangleShape extends ShapeBorder {
  const TriangleShape({
    required this.color,
    required this.colorShadow,
    required this.path,
  });

  final Color color;
  final Path path;

  final Color colorShadow;
  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    var paint = Paint();
    paint.color = colorShadow;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawPath(path, paint);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => path;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => path;

  @override
  ShapeBorder scale(double t) => this;
}
