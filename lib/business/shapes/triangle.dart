import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/business/shapes/shapeable.dart';
import 'package:tangram/util/coordinateSystem.dart';

class Triangle extends BaseShape implements IMovable {
  // static Map<PointSystem, List<PointSystem>> pattern = {
  //   PointSystem(dx: 0, dy: 0, west: false, north: false): [],
  //   PointSystem(dx: 0, dy: 0): [],
  //   PointSystem(dx: 0, dy: 0, west: false, north: false): [
  //     PointSystem(dx: 0, dy: 0, west: false, north: false, east: false, south: false),
  //     PointSystem(dx: 0, dy: 0, west: true, north: false, east: false, south: true),
  //     PointSystem(dx: 0, dy: 0, west: true, north: true, east: true, south: true),
  //     PointSystem(dx: 0, dy: 0, west: true, north: false, east: false, south: true),
  //   ],
  //   PointSystem(dx: 0, dy: 0, west: false, north: false, east: false, south: false): [],
  // };

  Triangle({
    int xPos = 1,
    int yPos = 1,
  }) : super(
          origin: Offset(xPos.toDouble(), yPos.toDouble()),
        ) {
    points.add(
      const PointSystem(dx: 0, dy: 1, west: false, north: false),
    );
    points.add(
      const PointSystem(dx: 1, dy: 1),
    );
    points.add(
      const PointSystem(dx: 1, dy: 0, west: false, north: false),
    );
  }

  @override
  List<PointSystem> rotateRight() {
    List<PointSystem> temps = List.of(points);
    List<PointSystem> pointsAfterRotation = [];

    points.forEach((PointSystem point) {
      PointSystem found = temps.firstWhere(
          (PointSystem element) => point.dx == element.dx && point.dy == element.dy);
      int dx = origin.dx.toInt() - point.dy + origin.dy.toInt();
      int dy = origin.dy.toInt() + point.dx - origin.dx.toInt();
      pointsAfterRotation.add(
        PointSystem(
          dx: dx,
          dy: dy,
          east: found.north,
          south: found.east,
          west: found.south,
          north: found.west,
        ),
      );
      temps.removeWhere((element) => element.dx == found.dx && point.dy == element.dy);
    });

    return pointsAfterRotation;
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
}

/*

class TriangleData extends BaseShapeData implements IShapeable {
  // static Map<PointSystem, List<PointSystem>> pattern = {
  //   PointSystem(dx: 0, dy: 0, west: false, north: false): [],
  //   PointSystem(dx: 0, dy: 0): [],
  //   PointSystem(dx: 0, dy: 0, west: false, north: false): [
  //     PointSystem(dx: 0, dy: 0, west: false, north: false, east: false, south: false),
  //     PointSystem(dx: 0, dy: 0, west: true, north: false, east: false, south: true),
  //     PointSystem(dx: 0, dy: 0, west: true, north: true, east: true, south: true),
  //     PointSystem(dx: 0, dy: 0, west: true, north: false, east: false, south: true),
  //   ],
  //   PointSystem(dx: 0, dy: 0, west: false, north: false, east: false, south: false): [],
  // };

  Triangle({
    int xPos = 0,
    int yPos = 0,
  }) : super(
    origin: Offset(xPos + 1, yPos.toDouble()),
  ) {
    points.add(
      PointSystem(dx: 0, dy: 1, west: false, north: false),
    );
    points.add(
      PointSystem(dx: 1, dy: 1),
    );
    points.add(
      PointSystem(dx: 1, dy: 0, west: false, north: false),
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
*/
