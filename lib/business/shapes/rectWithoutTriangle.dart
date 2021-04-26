import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/util/coordinateSystem.dart';

class RectWithoutTriangle extends BaseShape {
  RectWithoutTriangle({
    int xPos = 2,
    int yPos = 2,
  }) : super(
          origin: Offset(xPos.toDouble(), yPos.toDouble()),
        ) {
    {
      points.add(PointSystem(dx: 1, dy: 3, west: false, south: false));
      points.add(PointSystem(dx: 2, dy: 3, east: false, south: false));

      points.add(PointSystem(dx: 0, dy: 2, west: false, south: false));
      points.add(PointSystem(
        dx: 1,
        dy: 2,
      ));
      points.add(PointSystem(dx: 2, dy: 2));
      points.add(PointSystem(dx: 3, dy: 2, east: false, south: false));

      points.add(PointSystem(dx: 0, dy: 1, west: false, north: false));
      points.add(PointSystem(dx: 1, dy: 1));

      points.add(PointSystem(dx: 1, dy: 0, west: false, north: false));
    }
  }
}
