import 'package:tangram/settings.dart';
import 'package:tangram/shapes/shapes.dart';

import 'coordinateSystem.dart';

class PuzzleToSolve implements BaseShape {
  //final Color color;
  final List<PointSystem> points = [];
  final int x;
  final int y;
  final Settings settings;

  PuzzleToSolve({
    //  required this.color,
    required this.x,
    required this.y,
    required this.settings,
  }) {
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
