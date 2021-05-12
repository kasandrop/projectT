part of 'movements_bloc.dart';

@immutable
class MovementsState extends Equatable {
  final Map<Shapes, BaseShape> baseShapeMap; //tracks rotation
  final Map<Shapes, Offset> positionsMap; //tracks position
  final Shapes focusShape; //currently focused shape
  final Offset delta;

  const MovementsState(
      {required this.baseShapeMap,
      required this.positionsMap,
      required this.focusShape,
      required this.delta});

  MovementsState copyWith({
    BaseShape? baseShape,
    Offset? currentPosition,
    Shapes? focusShape,
    Offset? delta,
  }) {
    baseShapeMap.update(focusShape ?? this.focusShape, (value) => baseShape ?? value);
    positionsMap.update(focusShape ?? this.focusShape, (value) => currentPosition ?? value);

    return MovementsState(
      baseShapeMap: baseShapeMap,
      positionsMap: positionsMap,
      focusShape: focusShape ?? this.focusShape,
      delta: delta ?? this.delta,
    );
  }

  @override
  List<Object> get props => [baseShapeMap, positionsMap, focusShape, delta];

  @override
  String toString() {
    return 'MovementsState{ \n'
        'List of points : ${baseShapeMap[focusShape]},\n'
        ' focusShape: $focusShape, \n'
        'delta: $delta}\n';
  }
}
