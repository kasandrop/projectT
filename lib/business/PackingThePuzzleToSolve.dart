import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/util/point_system.dart';
import 'package:tangram/util/shape_enum.dart';

class PackingThePuzzleToSolve {
  final List<PointSystem> puzzleToSolvePoints;
  final Map<PointSystem, int> currentlyCoveredPuzzle = <PointSystem, int>{};
  bool solved = false;
  final int pointsToPack;

  var pointsCovered = 0;

  PackingThePuzzleToSolve({
    required this.puzzleToSolvePoints,
    //  required this.positionsMap,
    //  required this.rotationMap,
    // required this.shapeFocused,
  }) : pointsToPack = puzzleToSolvePoints.length {
    puzzleToSolvePoints.forEach((element) {
      currentlyCoveredPuzzle[element] = 0;
    });
  }

  bool get isSolved => solved;

  void dragStarted(ShapeStartedDragData data) {
    data.points.forEach((PointSystem point) {
      var newPoint = point + data.offset;
      if (currentlyCoveredPuzzle.containsKey(newPoint)) {
        currentlyCoveredPuzzle[newPoint] =
            currentlyCoveredPuzzle[newPoint]! - 1;
        if (currentlyCoveredPuzzle[newPoint] == 0) {
          pointsCovered--;
        }
      }
    });
  }

  void dragFinished(ShapeFinishedDragData data) {
    data.points.forEach((PointSystem point) {
      var newPoint = point + data.offset;
      if (currentlyCoveredPuzzle.containsKey(newPoint)) {
        currentlyCoveredPuzzle[newPoint] =
            currentlyCoveredPuzzle[newPoint]! + 1;
        if (currentlyCoveredPuzzle[newPoint] == 1) {
          pointsCovered++;
          if (pointsToPack == pointsCovered) {
            solved = true;
          }
        }
      }
    });
  }
}

class ShapeStartedDragData {
  final Shapes shape;
  final Offset offset;
  final List<PointSystem> points;

  ShapeStartedDragData({
    required this.shape,
    required this.offset,
    required this.points,
  });

  @override
  String toString() {
    return 'ShapeStartedDragData{shape: $shape, offset: $offset, points: $points}';
  }
}

class ShapeFinishedDragData {
  final BaseShape shape;
  final Offset offset;
  final List<PointSystem> points;

  ShapeFinishedDragData({
    required this.shape,
    required this.offset,
    required this.points,
  });

  @override
  String toString() {
    return 'ShapeFinishedDragData{shape: $shape, offset: $offset, points: $points}';
  }
}
