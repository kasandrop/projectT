import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/data/models/point_system.dart';

@override
class SolverState extends Equatable {
  //puzzle which must be covered
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

  int draggingStarted(int result) {
    if (result == 0) {
      return -1;
    }
    return 0;
  }

  int draggingFinished(int result) {
    if (result == 1) {
      return 1;
    }
    return 0;
  }

  SolverState copyWithShapeStartedDragData({
    required Offset offset,
    required List<PointSystem> points,
  }) {
    //   PointSystem ps=const PointSystem.north(dx: 7, dy: 7);
    //   bool result=currentlyCoveredPuzzle.containsKey(ps);
    // log.d(' Contains =$result');
    return _copyWith(
        points: points, offset: offset, func: subtractOne, plusMinus: draggingStarted);
  }

  SolverState copyWithShapeFinishedDragData({
    required Offset offset,
    required List<PointSystem> points,
  }) {
    return _copyWith(
        points: points, offset: offset, func: addingOne, plusMinus: draggingFinished);
  }

  SolverState copyWithShapeFinishedRotation({
    required Offset offset,
    required List<PointSystem> points,
  }) {
    return _copyWith(
        points: points, offset: offset, func: addingOne, plusMinus: draggingFinished);
  }

  SolverState _copyWith({
    required Offset offset,
    required List<PointSystem> points,
    required Function func,
    required Function plusMinus,
  }) {
    var delta = 0;
    var boolSolved = false;
    points.forEach((PointSystem point) {
      var newPoint = point + offset;
      if (newPoint.south == true) {
        var temp = PointSystem.south(dx: newPoint.dx, dy: newPoint.dy);
        delta += _decInc(temp, func, plusMinus);
      }
      if (newPoint.west == true) {
        var temp = PointSystem.west(dx: newPoint.dx, dy: newPoint.dy);
        delta += _decInc(temp, func, plusMinus);
      }
      if (newPoint.north == true) {
        var temp = PointSystem.north(dx: newPoint.dx, dy: newPoint.dy);
        delta += _decInc(temp, func, plusMinus);
      }
      if (newPoint.east == true) {
        var temp = PointSystem.east(dx: newPoint.dx, dy: newPoint.dy);
        delta += _decInc(temp, func, plusMinus);
      }
    });
    if ((pointsCovered + delta) == pointsToPack) {
      boolSolved = true;
    }
    return SolverState(
        puzzleToSolvePoints: puzzleToSolvePoints,
        currentlyCoveredPuzzle: currentlyCoveredPuzzle,
        solved: boolSolved,
        pointsCovered: pointsCovered + delta,
        pointsToPack: pointsToPack);
  }

  /*
  func   if dragging started subtract  if dragging finished add.
  pointsCoveredFunction  if dragging started
   */
  int _decInc(PointSystem newPoint, Function func, Function plusMinus) {
    if (currentlyCoveredPuzzle.containsKey(newPoint)) {
      currentlyCoveredPuzzle[newPoint] = func(currentlyCoveredPuzzle[newPoint]);
      int result = plusMinus(currentlyCoveredPuzzle[newPoint]);
      return result;
    }
    return 0;
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
