part of 'movements_bloc.dart';

//TODO: remove  base class
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

class ShapeDragged extends MovementsEvent {
  //real point because delta keeps repeating and event will not be send

  final Offset delta;

  const ShapeDragged({
    required this.delta,
  }) : super();

  @override
  List<Object> get props => [delta];
}

class ShapeUnFocused extends MovementsEvent {}

class RotatedRight extends MovementsEvent {}

class RotatedLeft extends MovementsEvent {}
