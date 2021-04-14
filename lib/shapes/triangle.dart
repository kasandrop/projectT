import 'package:tangram/shapes/baseShape.dart';

import '../coordinateSystem.dart';

class Triangle extends BaseShape {
  //final List<PointSystem> points = [];
  Triangle({
    required int x,
    required int y,
  }) : super(
        //  color: Colors.red,
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
}
