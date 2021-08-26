import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triangram/blocs/data/data.dart';
import 'package:triangram/data/models/puzzle.dart';
import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/shape_order.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/top_level_functions.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final GameShapes gameShapes;
  final ShapeOrder shapeOrder;
  late final Puzzle puzzle;

  DataBloc({
    required this.gameShapes,
    required this.shapeOrder,
  }) : super(DataState(gameShapes: gameShapes, shapeOrder: shapeOrder, solve: false));

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is PositionEvent) {
      yield state.copyWith(
          solve: true,
          positionOfBoundingRectangle: normalizeOffset(
              boundingRect: event.positionOfBoundingRectangle,
              pointsPath: puzzle.pointsAfterAlignment(),
              pointsOfShape: state.pointsOfFocusPolygon));
    }
    if (event is FocusEvent) {
      yield state.copyWith(focusShape: event.focusShape, solve: false);
    }
    if (event is HideShapeEvent) {
      yield state.copyWith(hideShape: event.hideShape, solve: false);
    }
    if (event is ShowShapeEvent) {
      yield state.copyWith(showShape: event.showShape, solve: true);
    }
    if (event is LeftRotationEvent) {
      yield state.copyWith(rotationLeft: true, solve: true);
    }
    if (event is RightRotationEvent) {
      yield state.copyWith(rotationRight: true, solve: true);
    }
  }
}
