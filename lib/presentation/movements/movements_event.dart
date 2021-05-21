//TODO: remove  base class
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/util/shape_enum.dart';

abstract class MovementsEvent extends Equatable {
  const MovementsEvent();

  @override
  List<Object> get props => [];
}

class ShapeFocused extends MovementsEvent {
  final Shapes focusShape;

  const ShapeFocused({required this.focusShape});

  @override
  List<Object> get props => [focusShape];
}

class DragStarted extends MovementsEvent {
  final int pointSizeInt;
  int get pointSize => pointSizeInt;

  const DragStarted({required this.pointSizeInt});

  @override
  List<Object> get props => [pointSizeInt];
}

class ShapeDragging extends MovementsEvent {
  //real point because delta keeps repeating and event will not be send

  final Offset delta;

  const ShapeDragging({
    required this.delta,
  }) : super();

  @override
  List<Object> get props => [delta];
}

class DraggingFinished extends MovementsEvent {}

class RotatedRight extends MovementsEvent {}

class RotatedLeft extends MovementsEvent {}
