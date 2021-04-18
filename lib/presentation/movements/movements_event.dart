part of 'movements_bloc.dart';

abstract class MovementsEvent extends Equatable {
  const MovementsEvent();

  @override
  List<Object> get props => [];
}

class ShapeFocused extends MovementsEvent {
  final String shapeId;

  const ShapeFocused({required this.shapeId});
}

class ShapeUnFocused extends MovementsEvent {}

class RotatedRight extends MovementsEvent {}

class RotatedLeft extends MovementsEvent {}

class ShapeMoved extends MovementsEvent {
  final double x;
  final double y;

  ShapeMoved({required this.x, required this.y});
}
