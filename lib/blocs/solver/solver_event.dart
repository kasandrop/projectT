import 'dart:ui';


import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/shape_enum.dart';

abstract class SolverEvent {
  const SolverEvent();
}

class PuzzleToSolveEvent extends SolverEvent {
  final Puzzle puzzle;

  const PuzzleToSolveEvent({
    required this.puzzle,
  });

  @override
  String toString() {
    return 'PuzzleToSolveEvent{puzzle: $puzzle}';
  }
}

class FocusEvent extends SolverEvent {
  final Shapes focusShape;

  const FocusEvent({required this.focusShape});

  @override
  String toString() {
    return 'FocusEvent{focusShape: $focusShape}';
  }
}


class HideFocusEvent extends SolverEvent {
  final Shapes focusShape;

  const HideFocusEvent({required this.focusShape});

  @override
  String toString() {
    return 'HideFocusEvent{focusShape: $focusShape}';
  }
}




class LeftRotationEvent extends SolverEvent{
  const LeftRotationEvent();
}

class RightRotationEvent extends SolverEvent{
  const RightRotationEvent();
}

class PositionEvent extends SolverEvent {
  final Offset positionOfBoundingRectangle;

  PositionEvent({required this.positionOfBoundingRectangle})
      : assert(positionOfBoundingRectangle.dx <= boardWidth),
        assert(positionOfBoundingRectangle.dy <= boardWidth);

  @override
  String toString() {
    return 'PositionEvent{offset: $positionOfBoundingRectangle}';
  }
}

//
// //TODO: Offset should be derived from dart.ui
// class ShapeStartedDragDataEvent extends SolverEvent {
//   final Offset offset;
//   final List<PointSystem> points;
//
//   const ShapeStartedDragDataEvent({
//     required this.offset,
//     required this.points,
//   }):super();
//
//   @override
//   String toString() {
//     return '\nShapeStartedDragDataEvent{ offset: $offset,\n points: $points}';
//   }
// }
//
// class ShapeFinishedDragDataEvent extends SolverEvent {
//   final Offset offset;
//   final List<PointSystem> points;
//
//   const ShapeFinishedDragDataEvent({
//     required this.offset,
//     required this.points,
//   }):super();
//
//   @override
//   String toString() {
//     return '\nShapeFinishedDragDataEvent{offset: $offset,\n points: $points}';
//   }
// }
//
// class ShapeFinishedRotation extends SolverEvent {
//   final Offset offset;
//   final List<PointSystem> points;
//
//   const ShapeFinishedRotation({
//     required this.offset,
//     required this.points,
//   });
//
//   @override
//   String toString() {
//     return '\nShapeFinishedRotation{offset: $offset,\n points: $points}';
//   }
// }
//
// class ShapeStartedRotation extends SolverEvent {
//   final Offset offset;
//   final List<PointSystem> points;
//
//   const ShapeStartedRotation({
//     required this.offset,
//     required this.points,
//   });
//
//   @override
//   String toString() {
//     return '\nShapeStartedRotation{offset: $offset,\n points: $points}';
//   }
// }
