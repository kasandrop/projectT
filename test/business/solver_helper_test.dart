import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tangram/business/PuzzleToSolve.dart';
import 'package:tangram/business/solver_helper.dart';
import 'package:tangram/util/point_system.dart';
import 'package:tangram/util/settings.dart';

class MockSettings extends Mock implements Settings {}

SolverHelper solverHelper = SolverHelper(
    puzzleToSolvePoints: PuzzleToSolve(
  x: 3,
  y: 4,
  settings: MockSettings(),
).points);
List<PointSystem>? points;

void main() {
  group('SolverHelper dependency of bloc test', () {
    setUp(() {
      points = solverHelper.puzzleToSolvePoints;
    });

    test(
        'initMap should return a Map where length'
        'is the same as count of List puzzleToSolve', () {
      expect(solverHelper.initMap().length, points?.length);
    });

    test('there are 24 points to match', () {
      expect(solverHelper.initMap().length, 24);
    });
  });
}
