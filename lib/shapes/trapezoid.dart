import '../coordinateSystem.dart';
import 'baseShape.dart';

class Trapezoid extends BaseShape {
  //final List<PointSystem> points = [];
  Trapezoid({
    required int x,
    required int y,
  }) : super(
        //   color: Colors.red,
        ) {
    points.add(PointSystem(dx: x, dy: y, west: false, north: false));
    points.add(PointSystem(dx: x + 1, dy: y));
    points.add(PointSystem(dx: x + 2, dy: y, east: false, south: false));

//----
    points.add(PointSystem(dx: x + 1, dy: y - 1, west: false, north: false));
    points.add(PointSystem(dx: x + 2, dy: y - 1));
    points.add(PointSystem(dx: x + 3, dy: y - 1, east: false, south: false));

//---
    points.add(PointSystem(dx: x + 2, dy: y - 2, west: false, north: false));
    points.add(PointSystem(dx: x + 3, dy: y - 2));

    //----
    points.add(PointSystem(dx: x + 3, dy: y - 3, west: false, north: false));
  }
}