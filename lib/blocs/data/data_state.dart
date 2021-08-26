import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/data/models/shape_order.dart';
import 'package:triangram/util/shape_enum.dart';

@immutable
class DataState extends Equatable {
  final GameShapes gameShapes;
  final ShapeOrder shapeOrder;
  final bool solve;

  const DataState({
    required this.gameShapes,
    required this.shapeOrder,
    required this.solve,
  });

  List<Offset> get pointsOfFocusPolygon => gameShapes.getShape(currentFocus!).pointsOfPolygon;

  ShapeProduct getShape(Shapes shape) => gameShapes.getShape(shape);

  //unit data
  Map<Shapes, MyPath> get pathOfAllShapes => gameShapes.getMyPathMap(pointSize: 1);

  // Path getPath({
  //   required Shapes shape,
  //   double pointSize=1,
  // }) =>
  //     getShape(shape).getPath(pointSize: pointSize);

  // Path getPath({required Shapes shape}) => getShape(shape).getPath();

  MyPath getMyPath({required Shapes shape}) => getShape(shape).getMyPath();

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
  List<Object> get props => [gameShapes, shapeOrder, solve];

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

  @override
  String toString() {
    return '''DataState{
      gameShapes: $gameShapes, 
      shapeOrder: $shapeOrder, 
      solve: $solve}
      
      ''';
  }
}
