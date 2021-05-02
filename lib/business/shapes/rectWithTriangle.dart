import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/business/shapes/shapeable.dart';
import 'package:tangram/util/coordinateSystem.dart';

class RectWithTriangle extends BaseShape implements IMovable {
  RectWithTriangle({
    int xPos = 2,
    int yPos = 2,
  }) : super(
          origin: Offset(xPos.toDouble(), yPos.toDouble()),
        ) {
    points.add(const PointSystem(dx: 2, dy: 0, east: false, north: false));
    points.add(const PointSystem(dx: 2, dy: 1));
    points.add(const PointSystem(dx: 3, dy: 1, east: false, north: false));
    points.add(const PointSystem(dx: 2, dy: 2));
    points.add(const PointSystem(dx: 3, dy: 2));
    points.add(const PointSystem(dx: 2, dy: 3));
    points.add(const PointSystem(dx: 3, dy: 3));
  }

  @override
  bool arePointsOutsideBoundaries({required int boardWidth, required int boardHeight}) {
    // TODO: implement arePointsOutsideBoundaries
    throw UnimplementedError();
  }

  @override
  List<PointSystem> rotateLeft() {
    // TODO: implement rotateLeft
    throw UnimplementedError();
  }

  @override
  List<PointSystem> rotateRight() {
    // TODO: implement rotateRight
    throw UnimplementedError();
  }
}
