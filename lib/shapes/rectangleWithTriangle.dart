import '../coordinateSystem.dart';
import 'baseShape.dart';

class RectangleWithTriangle extends BaseShape {
  RectangleWithTriangle({
    required int x,
    required int y,
  }) : super(
        //color: Colors.red,
        ) {
    points.add(PointSystem(dx: x, dy: y, west: false, north: false));
    points.add(PointSystem(dx: x + 1, dy: y));
    points.add(PointSystem(dx: x + 1, dy: y - 1, west: false, north: false));
    points.add(PointSystem(dx: x + 2, dy: y));
    points.add(PointSystem(dx: x + 3, dy: y));
    points.add(PointSystem(dx: x + 2, dy: y - 1));
    points.add(PointSystem(dx: x + 3, dy: y - 1));
  }
}