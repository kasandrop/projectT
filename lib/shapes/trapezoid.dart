import 'package:flutter/material.dart';

import '../coordinateSystem.dart';
import 'baseShape.dart';

class Trapezoid extends BaseShape {
  //final List<PointSystem> points = [];
  Trapezoid({required width})
      : super(
          color: Colors.red,
          width: width,
        ) {
    points
        .add(PointSystem(dx: (width / 2 - 1).floor(), dy: 0, west: false, north: false));
    points.add(PointSystem(dx: (width / 2).floor(), dy: 0));
    points
        .add(PointSystem(dx: (width / 2 + 1).floor(), dy: 0, east: false, south: false));
//----
    points
        .add(PointSystem(dx: (width / 2 - 2).floor(), dy: -1, west: false, north: false));
    points.add(PointSystem(dx: (width / 2 - 1).floor(), dy: -1));
    points.add(PointSystem(dx: (width / 2).floor(), dy: -1, east: false, south: false));
//---
    points.add(PointSystem(dx: (width / 2 - 2).floor(), dy: -2));
    points
        .add(PointSystem(dx: (width / 2 - 1).floor(), dy: -2, east: false, south: false));
    //----
    points
        .add(PointSystem(dx: (width / 2 - 2).floor(), dy: -3, east: false, south: false));
  }
}
