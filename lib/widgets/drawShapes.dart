import 'package:flutter/material.dart';
import 'package:tangram/businessLogic/coordinateSystem.dart';
import 'package:tangram/businessLogic/shapes/baseShape.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/widgets/drawPoint.dart';

class DrawShapes extends StatelessWidget {
  final List<BaseShape> shapes;

  final Settings settings;
  final Color color;

  DrawShapes({
    required this.shapes,
    required this.settings,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Positioned> visiblePoints = [];
    shapes.forEach((BaseShape shape) {
      shape.points.forEach((PointSystem point) {
        print('visible points x:${point.dx} y:${point.dy}');
        visiblePoints.add(Positioned(
          top: point.dy * settings.pointSize.toDouble(),
          left: point.dx * settings.pointSize.toDouble(),
          child: DrawPoint(
            settings: settings,
            pointSystem: point,
            color: color,
          ),
        ));
      });
    });
    print('visible points size:${visiblePoints.length}');
    return Stack(children: visiblePoints);
  }
}
