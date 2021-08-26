import 'dart:ui';

import 'package:triangram/data/models/puzzle.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/util/shape_enum.dart';

abstract class SolverEvent {
  const SolverEvent();
}

class UpdateMapEvent extends SolverEvent {
  final Map<Shapes, MyPath> map;

  const UpdateMapEvent({required this.map});

  @override
  String toString() {
    return 'UpdateMapEvent{map: $map}';
  }
}
