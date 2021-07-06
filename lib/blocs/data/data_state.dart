import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/shape_enum.dart';

@immutable
class DataState extends Equatable {
  final GameShapes gameShapes;
  final ShapeOrder shapeOrder;
  final bool solve;

  DataState({
    required this.gameShapes,
    required this.shapeOrder,
    this.solve = true,
  });

  ShapeProduct getShape(Shapes shape) => gameShapes.getShape(shape);

  //unit data
  Map<Shapes, Path> get pathOfAllShapes => gameShapes.getPathMap(1);

  // Path getPath({
  //   required Shapes shape,
  //   double pointSize=1,
  // }) =>
  //     getShape(shape).getPath(pointSize: pointSize);

  Path getPathForUi({
    required Shapes shape,
    required double pointSize,
  }) =>
      getShape(shape).getPathForUi(pointSize);

  Shapes? get currentFocus => shapeOrder.focusShape;

  bool get _isPositionInAllShapesEven => gameShapes.isPositionInAllShapesEven;

  bool get _areAllShapesShown => shapeOrder.isShapeOrderFull;

  bool isSolved() {
    if (solve == true && _isPositionInAllShapesEven == true && _areAllShapesShown == true) {
      return true;
    }
    return false;
  }

  @override
  List<Object> get props => [
        gameShapes,
        shapeOrder,
      ];

  @override
  bool get stringify => true;

  DataState copyWith({
    Shapes? showShape,
    Shapes? hideShape,
    Shapes? focusShape,
    GameShapes? gameShapes,
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft,
    bool? rotationRight,
    Shapes? hideFocusShape,
    bool? solve,
  }) {
    if (hideShape != null) {
      var newShapeOrder = shapeOrder.copyWith(removeShape: hideShape);
      return DataState(
        shapeOrder: newShapeOrder,
        gameShapes: this.gameShapes,
        solve: solve ?? this.solve,
      );
    }

    if (showShape != null) {
      var newShapeOrder = shapeOrder.copyWith(addShape: showShape);
      return DataState(
        shapeOrder: newShapeOrder,
        gameShapes: this.gameShapes,
        solve: solve ?? this.solve,
      );
    }

    ShapeOrder newShapeOrder;
    if (focusShape != null) {
      newShapeOrder = shapeOrder.copyWith(newFocusShape: focusShape);
    } else {
      newShapeOrder = shapeOrder;
    }

    return (positionOfBoundingRectangle != null || rotationLeft != null || rotationRight != null)
        ? DataState(
            shapeOrder: newShapeOrder,
            gameShapes: this.gameShapes.copyWith(
                shape: newShapeOrder.order.last,
                rotationLeft: rotationLeft,
                positionOfBoundingRectangle: positionOfBoundingRectangle,
                rotationRight: rotationRight),
            solve: solve ?? this.solve,
          )
        : DataState(
            shapeOrder: newShapeOrder,
            gameShapes: gameShapes ?? this.gameShapes,
            solve: solve ?? this.solve,
          );
  }
}
