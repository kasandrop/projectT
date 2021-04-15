import 'package:flutter/material.dart';
import 'package:tangram/shapes/baseShape.dart';
import 'package:tangram/shapes/shapeable.dart';

import '../coordinateSystem.dart';

class Triangle extends BaseShape implements IShapeable {
  static Map<PointSystem, List<PointSystem>> pattern = {
    PointSystem(dx: 0, dy: 0, west: false, north: false): [],
    PointSystem(dx: 0, dy: 0): [],
    PointSystem(dx: 0, dy: 0, west: false, north: false): [
      PointSystem(dx: 0, dy: 0, west: false, north: false, east: false, south: false),
      PointSystem(dx: 0, dy: 0, west: true, north: false, east: false, south: true),
      PointSystem(dx: 0, dy: 0, west: true, north: true, east: true, south: true),
      PointSystem(dx: 0, dy: 0, west: true, north: false, east: false, south: true),
    ],
    PointSystem(dx: 0, dy: 0, west: false, north: false, east: false, south: false): [],
  };
  Triangle({
    required int x,
    required int y,
    required color,
  }) : super(
          color: color,
          origin: Offset(x + 1, y.toDouble()),
        ) {
    points.add(
      PointSystem(dx: x, dy: y, west: false, north: false),
    );
    points.add(
      PointSystem(dx: x + 1, dy: y),
    );
    points.add(
      PointSystem(dx: x + 1, dy: y - 1, west: false, north: false),
    );
  }

  // PointSystem swapDirectionRight(PointSystem oldPointSystem){
  //
  //   return
  // }

  @override
  bool arePointsOutsideBoundaries({required int boardWidth, required int boardHeight}) {
    // TODO: implement arePointsOutsideBoundaries
    throw UnimplementedError();
  }

  @override
  rotateLeft() {
    // TODO: implement rotateLeft
    throw UnimplementedError();
  }

  @override
  rotateRight() {
    points.forEach((PointSystem point) {
      PointSystem tempPoint = point;
    });
  }
}
