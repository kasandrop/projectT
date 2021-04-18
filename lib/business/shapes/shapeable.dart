import '../coordinateSystem.dart';

abstract class IShapeable {
  List<PointSystem> rotateLeft();

  List<PointSystem> rotateRight();

  bool arePointsOutsideBoundaries({
    required int boardWidth,
    required int boardHeight,
  });
}
