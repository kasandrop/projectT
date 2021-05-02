part of 'movements_bloc.dart';

@immutable
class MovementsState extends Equatable {
  final Map<Shapes, List<PointSystem>> pointsMap;
  final Map<Shapes, Offset> positionsMap;
  final Shapes focusShape; //currently focused shape
  final Offset delta;

  const MovementsState(
      {required this.pointsMap,
      required this.positionsMap,
      required this.focusShape,
      required this.delta});

  MovementsState copyWith({
    Map<Shapes, List<PointSystem>>? pointsMap,
    Offset? currentPosition,
    Shapes? focusShape,
    Offset? delta,
  }) {
    this
        .positionsMap
        .update(focusShape ?? this.focusShape, (value) => currentPosition ?? value);
    return MovementsState(
      pointsMap: pointsMap ?? this.pointsMap,
      positionsMap: this.positionsMap,
      focusShape: focusShape ?? this.focusShape,
      delta: delta ?? this.delta,
    );
  }

  @override
  List<Object> get props => [pointsMap, positionsMap, focusShape, delta];

  @override
  String toString() {
    return 'MovementsState{ '
        'positionsMap: $positionsMap,'
        ' focusShape: $focusShape, delta: $delta}';
  }
}
