import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/util/coordinateSystem.dart';

class RectWithTriangle extends BaseShape {
  RectWithTriangle({
    int xPos = 2,
    int yPos = 2,
  }) : super(
          origin: Offset(xPos.toDouble(), yPos.toDouble()),
        ) {
    points.add(PointSystem(dx: 2, dy: 0, east: false, north: false));
    points.add(PointSystem(dx: 2, dy: 1));
    points.add(PointSystem(dx: 3, dy: 1, east: false, north: false));
    points.add(PointSystem(dx: 2, dy: 2));
    points.add(PointSystem(dx: 3, dy: 2));
    points.add(PointSystem(dx: 2, dy: 3));
    points.add(PointSystem(dx: 3, dy: 3));
  }
}
