import 'package:tangram/data/models/point_system.dart';

class SolverHelper {
  final List<PointSystem> puzzleToSolvePoints;
  late final length;

  SolverHelper({required this.puzzleToSolvePoints});

  Map<PointSystem, int> initMap() {
    //log.d('SolverHelper-initMap');
    var currentlyCoveredPuzzle = <PointSystem, int>{};
    puzzleToSolvePoints.forEach((element) {
      if (element.south == true) {
        var temp = PointSystem.south(dx: element.dx, dy: element.dy);
        currentlyCoveredPuzzle[temp] = 0;
      }
      if (element.west == true) {
        var temp = PointSystem.west(dx: element.dx, dy: element.dy);
        currentlyCoveredPuzzle[temp] = 0;
      }
      if (element.north == true) {
        var temp = PointSystem.north(dx: element.dx, dy: element.dy);
        currentlyCoveredPuzzle[temp] = 0;
      }
      if (element.east == true) {
        var temp = PointSystem.east(dx: element.dx, dy: element.dy);
        currentlyCoveredPuzzle[temp] = 0;
      }
    });
    length = currentlyCoveredPuzzle.length;
    return currentlyCoveredPuzzle;
  }
}
