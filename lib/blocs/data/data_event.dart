import 'dart:ui';

import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/shape_enum.dart';

abstract class DataEvent {
  const DataEvent();
}

class FocusEvent extends DataEvent {
  final Shapes focusShape;

  const FocusEvent({required this.focusShape});

  @override
  String toString() {
    return 'FocusEvent{focusShape: $focusShape}';
  }
}

class ShowShapeEvent extends DataEvent {
  final Shapes showShape;

  const ShowShapeEvent({required this.showShape});

  @override
  String toString() {
    return 'ShowEvent{ShowShape: $showShape}';
  }
}

class HideShapeEvent extends DataEvent {
  final Shapes hideShape;

  const HideShapeEvent({required this.hideShape});

  @override
  String toString() {
    return 'HideShapeEvent{hideShape: $hideShape}';
  }
}

class LeftRotationEvent extends DataEvent {
  const LeftRotationEvent();

  @override
  String toString() {
    return 'LeftRotationEvent{}';
  }
}

class RightRotationEvent extends DataEvent {
  const RightRotationEvent();

  @override
  String toString() {
    return 'RightRotationEvent{}';
  }
}

class PositionEvent extends DataEvent {
  //unit Data
  final Offset positionOfBoundingRectangle;

  //final Shapes focusShape;
  PositionEvent({
    required this.positionOfBoundingRectangle,
    // required this.focusShape,
  });

  @override
  String toString() {
    return 'PositionEvent{positionOfBoundingRectangle: $positionOfBoundingRectangle}';
  }

// : assert(positionOfBoundingRectangle.dx <= boardWidth),
//   assert(positionOfBoundingRectangle.dy <= boardWidth);
}
