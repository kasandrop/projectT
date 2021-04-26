part of 'movements_bloc.dart';

abstract class MovementsEvent extends Equatable {
  const MovementsEvent();

  @override
  List<Object> get props => [];
}

class ShapeFocused extends MovementsEvent {
  final Shapes shape;

  const ShapeFocused({required this.shape});

  @override
  List<Object> get props => [shape];
}

class ShapeUnFocused extends MovementsEvent {}

class RotatedRight extends MovementsEvent {}

class RotatedLeft extends MovementsEvent {}
