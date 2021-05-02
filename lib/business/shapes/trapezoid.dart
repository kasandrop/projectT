import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/business/shapes/shapeable.dart';
import 'package:tangram/util/coordinateSystem.dart';

class Trapezoid extends BaseShape implements IMovable {
  //final List<PointSystem> points = [];
  Trapezoid({
    int xPos = 2,
    int yPos = 2,
  }) : super(
          origin: Offset(xPos.toDouble(), yPos.toDouble()),
        ) {
    points.add(const PointSystem(dx: 0, dy: 3, west: false, north: false));
    points.add(const PointSystem(dx: 1, dy: 3));
    points.add(const PointSystem(dx: 2, dy: 3, east: false, south: false));

//----
    points.add(const PointSystem(dx: 1, dy: 2, west: false, north: false));
    points.add(const PointSystem(dx: 2, dy: 2));
    points.add(const PointSystem(dx: 3, dy: 2, east: false, south: false));

//---
    points.add(const PointSystem(dx: 2, dy: 1, west: false, north: false));
    points.add(const PointSystem(dx: 3, dy: 1));

    //----
    points.add(const PointSystem(dx: 3, dy: 0, west: false, north: false));
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
