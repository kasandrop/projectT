import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/blocs/data/data.dart';
import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/logger.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final GameShapes gameShapes;
  final ShapeOrder shapeOrder;

  DataBloc({
    required this.gameShapes,
    required this.shapeOrder,
  }) : super(DataState(gameShapes: gameShapes, shapeOrder: shapeOrder));

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is PositionEvent) {
      //unit data
      yield state.copyWith(
          solve: true, positionOfBoundingRectangle: event.positionOfBoundingRectangle);
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

  @override
  void onTransition(Transition<DataEvent, DataState> transition) {
    super.onTransition(transition);
  }
}
