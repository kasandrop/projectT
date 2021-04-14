import '../coordinateSystem.dart';
import 'baseShape.dart';

class RectangleWithoutTriangle extends BaseShape {
  RectangleWithoutTriangle({
    required int x,
    required int y,
  }) : super(
        //  color: Colors.red,
        ) {
    {
      points.add(PointSystem(
        dx: x,
        dy: y,
      ));
      points.add(PointSystem(dx: x + 1, dy: y, east: false, south: false));
      points.add(PointSystem(dx: x + 1, dy: y + 1, east: false, north: false));
      points.add(PointSystem(dx: x, dy: y + 1));
    }
  }
}