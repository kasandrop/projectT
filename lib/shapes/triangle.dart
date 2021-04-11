import 'package:flutter/material.dart';
import 'package:tangram/shapes/baseShape.dart';

import '../coordinateSystem.dart';

class Triangle extends BaseShape {
  //final List<PointSystem> points = [];
  Triangle({required width})
      : super(
          color: Colors.red,
          width: width,
        ) {
    points.add(
      PointSystem(dx: (width / 2 - 1).floor(), dy: 0),
    );
    points.add(
      PointSystem(dx: (width / 2).floor(), dy: 0, east: false, south: false),
    );
    points.add(
      PointSystem(dx: (width / 2 - 1).floor(), dy: -1, east: false, south: false),
    );
  }
}
