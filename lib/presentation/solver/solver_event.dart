part of 'solver_bloc.dart';

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
    return 'ShapeStartedDragDataEvent{ offset: $offset, points: $points}';
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
    return 'ShapeFinishedDragDataEvent{offset: $offset, points: $points}';
  }
}
