import 'package:flutter/material.dart';
import 'package:tangram/business/coordinateSystem.dart';
import 'package:tangram/business/shapes/triangle.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/settings.dart';

class TriangleWidget extends StatelessWidget {
  final Triangle baseShape;
  final int x;
  final int y;
  final Settings settings;
  final Color color;

  const TriangleWidget({
    required this.baseShape,
    required this.settings,
    required this.color,
    required this.x,
    required this.y,
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
    return Positioned(
      top: y * settings.pointSize.toDouble(),
      left: x * settings.pointSize.toDouble(),
      child: Draggable(
        child: Container(
            height: settings.pointSize * 2,
            width: settings.pointSize * 2,
            child: Stack(children: visiblePoints)),
        feedback: Container(
            height: settings.pointSize * 2,
            width: settings.pointSize * 2,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/triangle.png"),
              ),
            )),
      ),
    );
  }
}
