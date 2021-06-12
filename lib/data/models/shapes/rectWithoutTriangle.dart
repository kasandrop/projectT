import 'package:flutter/material.dart';
import 'package:tangram/data/models/point_system.dart';

import 'baseShape.dart';

/*
List<int> list = [1, 2, 3];
var map = Map<String, int>.fromIterable(list,
    key: (item) => item.toString(),
    value: (item) => item * item);
 */
class RectWithoutTriangle extends BaseShape {
  RectWithoutTriangle({Offset origin = const Offset(2, 2)}) : super(origin: origin) {
    {
      points.add(const PointSystem(dx: 1, dy: 0, west: false, north: false));

      points.add(const PointSystem(dx: 1, dy: 3, west: false, south: false));
      points.add(const PointSystem(dx: 2, dy: 3, east: false, south: false));

      points.add(const PointSystem(dx: 0, dy: 2, west: false, south: false));
      points.add(const PointSystem(dx: 1, dy: 2));
      points.add(const PointSystem(dx: 2, dy: 2));
      points.add(const PointSystem(dx: 3, dy: 2, east: false, south: false));

      points.add(const PointSystem(dx: 0, dy: 1, west: false, north: false));
      points.add(const PointSystem(dx: 1, dy: 1));
    }
  }

  @override
  List<PointSystem> rotateLeft() {
    // TODO: implement rotateLeft
    throw UnimplementedError();
  }
}
