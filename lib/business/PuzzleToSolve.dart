import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/util/settings.dart';

import '../util/point_system.dart';

class PuzzleToSolve extends BaseShape {
  //final Color color;

  final Settings settings;

  PuzzleToSolve({
    required num x,
    required num y,
    required this.settings,
  }):super(origin:Offset(x.toDouble(),y.toDouble())) {
    points.add(PointSystem(dx: x + 2, dy: y));
    points.add(PointSystem(dx: x + 3, dy: y));

    points.add(PointSystem(dx: x + 2, dy: y + 1));
    points.add(PointSystem(dx: x + 3, dy: y + 1));

    points.add(PointSystem(dx: x + 2, dy: y + 2));
    points.add(PointSystem(dx: x + 3, dy: y + 2));

    points.add(PointSystem(dx: x + 2, dy: y + 3));
    points.add(PointSystem(dx: x + 3, dy: y + 3));

    points.add(PointSystem(dx: x + 2, dy: y + 4));
    points.add(PointSystem(dx: x + 3, dy: y + 4));

    points.add(PointSystem(dx: x + 2, dy: y + 5));
    points.add(PointSystem(dx: x + 3, dy: y + 5));

    points.add(PointSystem(dx: x + 2, dy: y + 6));
    points.add(PointSystem(dx: x + 3, dy: y + 6));

    points.add(PointSystem(dx: x + 2, dy: y + 7));
    points.add(PointSystem(dx: x + 3, dy: y + 7));

    points.add(PointSystem(dx: x, dy: y + 2));
    points.add(PointSystem(dx: x + 1, dy: y + 2));

    points.add(PointSystem(dx: x + 4, dy: y + 2));
    points.add(PointSystem(dx: x + 5, dy: y + 2));

    points.add(PointSystem(dx: x, dy: y + 3));
    points.add(PointSystem(dx: x + 1, dy: y + 3));

    points.add(PointSystem(dx: x + 4, dy: y + 3));
    points.add(PointSystem(dx: x + 5, dy: y + 3));
  }

  @override
  String toString() {
    return 'PuzzleToSolve{points: $points}';
  }
}
