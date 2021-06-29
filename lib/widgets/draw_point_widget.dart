import 'package:flutter/material.dart';
import 'package:tangram/data/models/point_system.dart';
import 'package:tangram/widgets/point_painter.dart';

class DrawPointWidget extends StatelessWidget {
  final PointSystem pointSystem;
  final Color color;
  final double pointSize;

  const DrawPointWidget({
    Key? key,
    required this.pointSystem,
    required this.color,
    required this.pointSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(pointSize, pointSize),
      painter: PointPainter(
        path: Path(),
        pointSize: pointSize,
        pointSystem: pointSystem,
        color: color,
        startPoint: Offset.zero,
      ),
    );
  }
}










