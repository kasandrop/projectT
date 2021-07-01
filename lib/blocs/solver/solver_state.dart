import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tangram/data/models/core/solver.dart';
import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/shape_enum.dart';

@immutable
class SolverState extends Equatable {
  final Puzzle puzzle;
  final GameShapes gameShapes;
  final ShapeOrder shapeOrder;

  SolverState(
      {required this.puzzle, required this.gameShapes, required this.shapeOrder
      //  required this.pointSize,
      });

  //will try with normalize values
  Path getPathOfPuzzle() => puzzle.getPath(1);

  ShapeProduct getShape(Shapes shape) => gameShapes.getShape(shape);

  Path getPath({
    required Shapes shape,
    required double pointSize,
  }) =>
      getShape(shape).getPath(pointSize);

  Path getPathForUi({
    required Shapes shape,
    required double pointSize,
  }) =>
      getShape(shape).getPathForUi(pointSize);

  Shapes get currentFocus => shapeOrder.focusShape;

  @override
  List<Object> get props => [puzzle, gameShapes, shapeOrder];

  @override
  bool get stringify => true;

  bool isSolved({required bool areAllShapesVisible}) => Solver.isWorkOut(
        gameShapes: gameShapes,
        puzzle: puzzle,
        areAllShapesVisible: areAllShapesVisible,
      );

  SolverState copyWith({
    Shapes? focusShape,
    Puzzle? puzzle,
    GameShapes? gameShapes,
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft,
    bool? rotationRight,
    // Shapes? hideFocusShape,
  }) {
    ShapeOrder newShapeOrder;
    if (focusShape != null) {
      //log.d('before Changing focus shape order:$shapeOrder ');
      newShapeOrder = shapeOrder.copyWith(newFocusShape: focusShape);
      //  log.d('after  Changing focus shape order:$newShapeOrder ');
    } else {
      //  log.d('no fokus change order: shape order:$shapeOrder ');
      newShapeOrder = shapeOrder;
    }

    return (positionOfBoundingRectangle != null ||
            rotationLeft != null ||
            rotationRight != null)
        ? SolverState(
            puzzle: puzzle ?? this.puzzle,
            shapeOrder: newShapeOrder,
            gameShapes: this.gameShapes.copyWith(
                shape: newShapeOrder.order.last,
                rotationLeft: rotationLeft,
                positionOfBoundingRectangle: positionOfBoundingRectangle,
                rotationRight: rotationRight),
          )
        : SolverState(
            shapeOrder: newShapeOrder,
            puzzle: puzzle ?? this.puzzle,
            gameShapes: gameShapes ?? this.gameShapes,
          );
  }
}
