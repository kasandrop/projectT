import 'dart:ui';

import 'package:tangram/util/point_system.dart';

abstract class SolverEvent {
  const SolverEvent();
}

//TODO: Offset should be derived from dart.ui
class ShapeStartedDragDataEvent extends SolverEvent {
  final Offset offset;
  final List<PointSystem> points;

  const ShapeStartedDragDataEvent({
    required this.offset,
    required this.points,
  });

  @override
  String toString() {
    return '\nShapeStartedDragDataEvent{ offset: $offset,\n points: $points}';
  }
}

class ShapeFinishedDragDataEvent extends SolverEvent {
  final Offset offset;
  final List<PointSystem> points;

  const ShapeFinishedDragDataEvent({
    required this.offset,
    required this.points,
  });

  @override
  String toString() {
    return '\nShapeFinishedDragDataEvent{offset: $offset,\n points: $points}';
  }
}

class ShapeFinishedRotation extends SolverEvent {
  final Offset offset;
  final List<PointSystem> points;

  const ShapeFinishedRotation({
    required this.offset,
    required this.points,
  });

  @override
  String toString() {
    return '\nShapeFinishedRotation{offset: $offset,\n points: $points}';
  }
}

class ShapeStartedRotation extends SolverEvent {
  final Offset offset;
  final List<PointSystem> points;

  const ShapeStartedRotation({
    required this.offset,
    required this.points,
  });

  @override
  String toString() {
    return '\nShapeStartedRotation{offset: $offset,\n points: $points}';
  }
}
