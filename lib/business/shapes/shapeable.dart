import 'package:tangram/util/coordinateSystem.dart';

abstract class IMovable {
  List<PointSystem> rotateLeft();

  List<PointSystem> rotateRight();

  bool arePointsOutsideBoundaries({
    required int boardWidth,
    required int boardHeight,
  });
}
