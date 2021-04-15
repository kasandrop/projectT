abstract class IShapeable {
  rotateLeft();

  rotateRight();

  bool arePointsOutsideBoundaries({
    required int boardWidth,
    required int boardHeight,
  });
}
