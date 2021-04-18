import 'package:flutter/material.dart';
import 'package:tangram/business/coordinateSystem.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/settings.dart';

abstract class ShapeWidget extends StatelessWidget {
  final BaseShape baseShape;

  final Settings settings;
  final Color color;

  const ShapeWidget({
    required this.baseShape,
    required this.settings,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Positioned> visiblePoints = [];

    baseShape.points.forEach((PointSystem point) {
      // print('visible points x:${point.dx} y:${point.dy}');
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
    //print('visible points size:${visiblePoints.length}');
    return Stack(children: visiblePoints);
  }
}
