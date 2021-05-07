import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/business/shapes/shapeable.dart';
import 'package:tangram/util/point_system.dart';

class Triangle extends BaseShape {
  Triangle({Offset origin=const Offset(2,2)}):super(origin:origin ) {
    points.add(
               const PointSystem(dx: 0, dy: 0, west: false, north: false, south: false, east: false));
    points.add(const PointSystem(dx: 0, dy: 1, west: false, north: false));
    points.add(const PointSystem(dx: 1, dy: 1));
    points.add(const PointSystem(dx: 1, dy: 0, west: false, north: false));
  }

  @override
  void rotateRight() {
    List offsetsTemp = <Offset>[
      Offset(0, 0),
      Offset(1, 0),
      Offset(1, 1),
      Offset(0, 1),
    ];
    List<PointSystem> temps = List.of(this.points);
    points.clear();

    PointSystem temp = PointSystem(
      dx: offsetsTemp[0].dx.toInt(),
      dy: offsetsTemp[0].dy.toInt(),
      west: temps[temps.length - 1].south,
      north: temps[temps.length - 1].west,
      south: temps[temps.length - 1].east,
      east: temps[temps.length - 1].north,
    );
    points.add(temp);
    int i = 1;
    temps.forEach((PointSystem e) {
      if (i == offsetsTemp.length) return;
      PointSystem toAdd = PointSystem(
        dx: offsetsTemp[i].dx.toInt(),
        dy: offsetsTemp[i].dy.toInt(),
        west: e.south,
        north: e.west,
        south: e.east,
        east: e.north,
      );
      i++;
      points.add(toAdd);
    });
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
