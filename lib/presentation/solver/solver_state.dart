part of 'solver_bloc.dart';

@override
class SolverState extends Equatable {
  final List<PointSystem> puzzleToSolvePoints;

  //tracking progress
  final Map<PointSystem, int> currentlyCoveredPuzzle;
  final bool solved;

  //how many points need to be covered to solve the puzzle
  final int pointsToPack;

  //how many points we still need to cover
  final int pointsCovered;

  const SolverState({
    required this.puzzleToSolvePoints,
    required this.currentlyCoveredPuzzle,
    required this.solved,
    required this.pointsToPack,
    required this.pointsCovered,
  });

  int addingOne(int x) => x + 1;

  int subtractOne(int x) => x - 1;

  SolverState copyWithShapeStartedDragData({
    required Offset offset,
    required List<PointSystem> points,
  }) {
    return _copyWith(points: points, offset: offset, func: subtractOne);
  }

  SolverState copyWithShapeFinishedDragData({
    required Offset offset,
    required List<PointSystem> points,
  }) {
    return _copyWith(points: points, offset: offset, func: addingOne);
  }

  SolverState _copyWith({
    required Offset offset,
    required List<PointSystem> points,
    required Function func,
  }) {
    var deltaPointsCovered = 0;
    var boolSolved = false;
    points.forEach((PointSystem point) {
      var newPoint = point + offset;
      if (currentlyCoveredPuzzle.containsKey(newPoint)) {
        currentlyCoveredPuzzle[newPoint] =
            func(currentlyCoveredPuzzle[newPoint]);
        if (currentlyCoveredPuzzle[newPoint] == 1) {
          deltaPointsCovered++;
          if (pointsToPack == pointsCovered) {
            boolSolved = true;
          }
        }
      }
    });
    return SolverState(
        puzzleToSolvePoints: puzzleToSolvePoints,
        currentlyCoveredPuzzle: currentlyCoveredPuzzle,
        solved: boolSolved,
        pointsCovered: pointsCovered + deltaPointsCovered,
        pointsToPack: pointsToPack);
  }

  // void dragFinished(ShapeFinishedDragData data) {

  @override
  // TODO: implement props
  List<Object> get props => [
        puzzleToSolvePoints,
        currentlyCoveredPuzzle,
        solved,
        pointsToPack,
        pointsCovered,
      ];

  @override
  String toString() {
    return 'SolverState{puzzleToSolvePoints: $puzzleToSolvePoints,'
        ' currentlyCoveredPuzzle: $currentlyCoveredPuzzle, '
        'solved: $solved, pointsToPack: $pointsToPack,'
        ' pointsCovered: $pointsCovered}';
  }
}
