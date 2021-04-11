import 'package:flutter/material.dart';

import '../coordinateSystem.dart';
import 'baseShape.dart';

class RectangleWithTriangle extends BaseShape {
  RectangleWithTriangle({required width})
      : super(
          color: Colors.red,
          width: width,
        ) {
    points.add(PointSystem(dx: (width / 2 - 2).floor(), dy: 0));
    points.add(PointSystem(dx: (width / 2 - 1).floor(), dy: 0));
    points.add(PointSystem(dx: (width / 2).floor(), dy: 0));
    points
        .add(PointSystem(dx: (width / 2 + 1).floor(), dy: 0, east: false, south: false));
  }
}
