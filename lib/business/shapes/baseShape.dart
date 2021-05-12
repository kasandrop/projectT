import 'package:flutter/material.dart';
import 'package:tangram/util/point_system.dart';

abstract class BaseShape {
  final Offset origin;
  final List<PointSystem> points = [];

  BaseShape({required this.origin});

  bool arePointsOutsideBoundaries(
      {required int boardWidth, required int boardHeight}) {
    // TODO: implement arePointsOutsideBoundaries
    throw UnimplementedError();
  }

  List<PointSystem> rotateLeft() {
    // TODO: implement rotateLeft
    throw UnimplementedError();
  }

  void rotateRight() {
    {
      var tempPoints = List<PointSystem>.of(points);
      points.clear();
      tempPoints.forEach(
        (PointSystem e) {
          var diffFromOriginT = e.getOffset() - origin;
          var diffFromOriginTRotated =
              Offset(diffFromOriginT.dy * (-1), diffFromOriginT.dx);
          var rotatedPoint = diffFromOriginTRotated + origin;
          var newPs = PointSystem.afterClockWiseRotation(
              dx: rotatedPoint.dx.toInt(), dy: rotatedPoint.dy.toInt(), ps: e);
          points.add(newPs);
          //  map.update(rotatedPoint, (value) => newPs);
        },
      );
    }
  }
}
//
// class DraggingMechanism {
//   Settings _settings;
//   Settings get settings => _settings ?? DraggingMechanism.check();
// }
