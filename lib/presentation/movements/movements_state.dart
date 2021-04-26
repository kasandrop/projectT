part of 'movements_bloc.dart';

abstract class MovementsState extends Equatable {
  const MovementsState();

  @override
  List<Object> get props => [];
}

class InitialPointSystemState extends MovementsState {
  final Map<Shapes, List<PointSystem>> pointsMap;

  InitialPointSystemState({required this.pointsMap});
  @override
  List<Object> get props => [pointsMap];
}

class FocusedShapePointSystemState extends MovementsState {
  final List<PointSystem> points;

  FocusedShapePointSystemState({required this.points});
  @override
  List<Object> get props => [points];
}
