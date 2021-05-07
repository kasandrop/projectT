import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/util/point_system.dart';

/*
List<int> list = [1, 2, 3];
var map = Map<String, int>.fromIterable(list,
    key: (item) => item.toString(),
    value: (item) => item * item);
 */
class RectWithoutTriangle extends BaseShape {
  final map = <Offset, PointSystem>{};

  RectWithoutTriangle({Offset origin = const Offset(2, 2)})
      : super(origin: origin) {
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

      map.addAll(Map<Offset, PointSystem>.fromIterable(
        points,
        key: (point) => Offset(point.dx.toDouble(), point.dy.toDouble()),
        value: (point) => point,
      ));
    }
  }


  @override
  List<PointSystem> rotateLeft() {
    // TODO: implement rotateLeft
    throw UnimplementedError();
  }

  ///knowing the location after the rotation we update the [PointSystem]with new values of  north east west south
  // PointSystem getPointSystemFromMap(Offset offset) {
  //   if (map.containsKey(offset)) {
  //     return map[offset]!;
  //   }
  //   PointSystem ps =
  //   PointSystem.zero(dx: offset.dx.toInt(), dy: offset.dy.toInt());
  //   map.putIfAbsent(offset, () => ps);
  //   return ps;
  // }


}
