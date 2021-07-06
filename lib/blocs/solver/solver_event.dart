import 'dart:ui';

import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/util/shape_enum.dart';

abstract class SolverEvent {
  const SolverEvent();
}

class UpdateMapEvent extends SolverEvent {
  final Map<Shapes, Path> map;

  const UpdateMapEvent({required this.map});

  @override
  String toString() {
    return 'UpdateMapEvent{map: $map}';
  }
}

class NoFreshUpdatesEvent extends SolverEvent {
  const NoFreshUpdatesEvent();

  @override
  String toString() {
    return 'NoFreshUpdatesEvent';
  }
}
