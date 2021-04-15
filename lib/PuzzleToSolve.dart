import 'package:flutter/material.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/shapes/shapes.dart';

import 'coordinateSystem.dart';

class PuzzleToSolve extends BaseShape {
  //final Color color;

  final Settings settings;

  PuzzleToSolve({
    required color,
    required int x,
    required int y,
    required this.settings,
  }) : super(origin: Offset(x + 3, y + 3), color: color) {
    points.add(new PointSystem(dx: x + 2, dy: y));
    points.add(new PointSystem(dx: x + 3, dy: y));

    points.add(new PointSystem(dx: x + 2, dy: y + 1));
    points.add(new PointSystem(dx: x + 3, dy: y + 1));

    points.add(new PointSystem(dx: x + 2, dy: y + 2));
    points.add(new PointSystem(dx: x + 3, dy: y + 2));

    points.add(new PointSystem(dx: x + 2, dy: y + 3));
    points.add(new PointSystem(dx: x + 3, dy: y + 3));

    points.add(new PointSystem(dx: x + 2, dy: y + 4));
    points.add(new PointSystem(dx: x + 3, dy: y + 4));

    points.add(new PointSystem(dx: x + 2, dy: y + 5));
    points.add(new PointSystem(dx: x + 3, dy: y + 5));

    points.add(new PointSystem(dx: x + 2, dy: y + 6));
    points.add(new PointSystem(dx: x + 3, dy: y + 6));

    points.add(new PointSystem(dx: x + 2, dy: y + 7));
    points.add(new PointSystem(dx: x + 3, dy: y + 7));

    points.add(new PointSystem(dx: x, dy: y + 2));
    points.add(new PointSystem(dx: x + 1, dy: y + 2));

    points.add(new PointSystem(dx: x + 4, dy: y + 2));
    points.add(new PointSystem(dx: x + 5, dy: y + 2));

    points.add(new PointSystem(dx: x, dy: y + 3));
    points.add(new PointSystem(dx: x + 1, dy: y + 3));

    points.add(new PointSystem(dx: x + 4, dy: y + 3));
    points.add(new PointSystem(dx: x + 5, dy: y + 3));
  }
}
