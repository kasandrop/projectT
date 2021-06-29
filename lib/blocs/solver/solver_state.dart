import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/data/models/core/solver.dart';
import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/shape_enum.dart';

class SolverState extends Equatable {
  final Puzzle puzzle;
  final GameShapes gameShapes;
  final Shapes topShape;

  SolverState({
    required this.puzzle,
    required this.gameShapes,
    //  required this.pointSize,
  }):topShape=gameShapes.currentFocus;

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

  Shapes get currentFocus => gameShapes.currentFocus;

  ShapeOrder get shapeOrder=>gameShapes.shapeOrder;
  //setting focus in the shapeOrder changes order of elements in List  no need to preserve
  set currentFocus(Shapes shape) {

    gameShapes.currentFocus = shape;
  }

  set hideFocus(Shapes shape) => gameShapes.hideFocus = shape;

  @override
  List<Object> get props => [puzzle, gameShapes,currentFocus];

  @override
  String toString() {
    var text = '';
    gameShapes.shapes.entries.forEach((element) {
      text = '${element.key}:${element.value}' + text;
    });
    return text + '\n currentFocus:$currentFocus';
  }

  bool isSolved() => Solver.isWorkOut(gameShapes: gameShapes, puzzle: puzzle);

  SolverState copyWith({
    Puzzle? puzzle,
    GameShapes? gameShapes,
    Offset? positionOfBoundingRectangle,
    Shapes? focusShape,
    bool? rotationLeft,
    bool? rotationRight,
   // Shapes? hideFocusShape,
  }) {
    if (focusShape != null) currentFocus = focusShape;
    return (positionOfBoundingRectangle != null ||
            rotationLeft != null ||
            rotationRight != null)
        ? SolverState(
            puzzle: puzzle ?? this.puzzle,
            gameShapes: this.gameShapes.copyWith(
                focusShape: currentFocus,
                rotationLeft: rotationLeft,
                positionOfBoundingRectangle: positionOfBoundingRectangle,
                rotationRight: rotationRight),
          )
        : SolverState(
            puzzle: puzzle ?? this.puzzle,
            gameShapes: gameShapes ?? this.gameShapes,
          );
  }
}
