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

class ShapeUnFocused extends MovementsEvent {}

class RotatedRight extends MovementsEvent {}

class RotatedLeft extends MovementsEvent {}
