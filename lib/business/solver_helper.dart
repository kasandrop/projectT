import 'package:tangram/util/point_system.dart';

class SolverHelper {
  Map<PointSystem, int> initMap(List<PointSystem> listOfPoints) {
    var currentlyCoveredPuzzle = <PointSystem, int>{};
    listOfPoints.forEach((element) {
      currentlyCoveredPuzzle[element] = 0;
    });
    return currentlyCoveredPuzzle;
  }
}
