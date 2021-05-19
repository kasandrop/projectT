import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/util/shape_enum.dart';

class MovementsState extends Equatable {
  final Map<Shapes, BaseShape> baseShapeMap; //tracks rotation
  final Map<Shapes, Offset> positionsMap; //tracks position
  final Shapes focusShape; //currently focused shape
  final Offset delta;
  final bool rotation; // flag needed for solverBloc

  const MovementsState(
      {required this.baseShapeMap,
      required this.positionsMap,
      required this.focusShape,
      required this.delta,
      required this.rotation});

  MovementsState copyWith({
    BaseShape? baseShape,
    Offset? currentPosition,
    Shapes? focusShape,
    Offset? delta,
    bool? rotation,
  }) {
    baseShapeMap.update(focusShape ?? this.focusShape, (value) => baseShape ?? value);
    positionsMap.update(focusShape ?? this.focusShape, (value) => currentPosition ?? value);

    return MovementsState(
      baseShapeMap: baseShapeMap,
      positionsMap: positionsMap,
      focusShape: focusShape ?? this.focusShape,
      delta: delta ?? this.delta,
      rotation: rotation ?? false,
    );
  }

  @override
  List<Object> get props =>
      [baseShapeMap, positionsMap, focusShape, delta, rotation];

  @override
  String toString() {
    return '\nMovementsState{ \n'
        'List of points : ${baseShapeMap[focusShape]},\n'
        ' focusShape: $focusShape, \n'
        'delta: $delta}\n'
        'rotation: $rotation}\n';
  }
}
