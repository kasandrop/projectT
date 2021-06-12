import 'package:flutter/material.dart';

class MovingMechanismUseCase {
  late int pointSize;

  MovingMechanismUseCase();

  //First element of the list is position  Offset, second cumulative delta
  List<Offset> changeStatePositionAndDelta({
    required Offset delta,
  }) {
    if (delta.dx >= pointSize) return [Offset(1, 0), Offset(0, delta.dy)];
    if (delta.dy >= pointSize) return [Offset(0, 1), Offset(delta.dx, 0)];
    if (delta.dx <= -pointSize) return [Offset(-1, 0), Offset(0, delta.dy)];
    if (delta.dy <= -pointSize) return [Offset(0, -1), Offset(delta.dx, 0)];
    return [Offset(0, 0), Offset(delta.dx, delta.dy)];
  }
}
