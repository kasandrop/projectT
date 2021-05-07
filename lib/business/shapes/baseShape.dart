import 'package:flutter/material.dart';
import 'package:tangram/util/point_system.dart';
import 'package:tangram/util/settings.dart';

abstract class BaseShape {
  final Offset origin;
  final List<PointSystem> points = [];

 BaseShape({required this.origin});

  bool arePointsOutsideBoundaries({required int boardWidth, required int boardHeight}) {
    // TODO: implement arePointsOutsideBoundaries
    throw UnimplementedError();
  }

  List<PointSystem> rotateLeft() {
    // TODO: implement rotateLeft
    throw UnimplementedError();
  }



  void rotateRight() {
    {
      List<PointSystem> tempPoints = List<PointSystem>.of(points);
      points.clear();
      tempPoints.forEach( ( PointSystem e) {
        Offset diffFromOriginT = e.getOffset()-origin;
        // log.d( ' $diffFromOriginT = ${e.getOffset()}-$origin');
        Offset diffFromOriginTRotated =
        Offset(diffFromOriginT.dy * (-1), diffFromOriginT.dx);
        // log.d(' $diffFromOriginTRotated=   Offset(diffFromOriginT.dy * (-1), diffFromOriginT.dx);   diffFromOriginT=$diffFromOriginT',);
        Offset rotatedPoint = diffFromOriginTRotated + origin;

        PointSystem newPs = PointSystem.afterClockWiseRotation(
            dx: rotatedPoint.dx.toInt(),
            dy: rotatedPoint.dy.toInt(),
            ps: e);
        //  , dx: rotatedPoint.dx.toInt(), dy: rotatedPoint.dy.toInt());
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
