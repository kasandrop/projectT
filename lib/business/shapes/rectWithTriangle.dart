import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/business/shapes/shapeable.dart';
import 'package:tangram/util/point_system.dart';

class RectWithTriangle extends BaseShape {
  RectWithTriangle({Offset origin = const Offset(2, 2)})
      : super(origin: origin) {
    points.add(const PointSystem(dx: 2, dy: 0, east: false, north: false));
    points.add(const PointSystem(dx: 2, dy: 1));
    points.add(const PointSystem(dx: 3, dy: 1, east: false, north: false));
    points.add(const PointSystem(dx: 2, dy: 2));
    points.add(const PointSystem(dx: 3, dy: 2));
    points.add(const PointSystem(dx: 2, dy: 3));
    points.add(const PointSystem(dx: 3, dy: 3));
  }

  @override
  bool arePointsOutsideBoundaries(
      {required int boardWidth, required int boardHeight}) {
    // TODO: implement arePointsOutsideBoundaries
    throw UnimplementedError();
  }

  @override
  List<PointSystem> rotateLeft() {
    // TODO: implement rotateLeft
    throw UnimplementedError();
  }

}
