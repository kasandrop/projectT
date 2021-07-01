import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/blocs/solver/solver.dart';
import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/logger.dart';

class SolverBloc extends Bloc<SolverEvent, SolverState> {
  final GameShapes gameShapes;
  final ShapeOrder shapeOrder;

  SolverBloc({
    required this.gameShapes,
    required this.shapeOrder,
  }) : super(SolverState(
            puzzle: Puzzle.zero(),
            gameShapes: gameShapes,
            shapeOrder: shapeOrder));

  @override
  Stream<SolverState> mapEventToState(SolverEvent event) async* {
    log.d('$event');
    if (event is PuzzleToSolveEvent) {
      yield state.copyWith(
        puzzle: event.puzzle,
      );
    }
    if (event is PositionEvent) {
      yield state.copyWith(
          positionOfBoundingRectangle: event.positionOfBoundingRectangle,
     //   focusShape: event.focusShape,
      );
    }
    if (event is FocusEvent) {
      yield state.copyWith(focusShape: event.focusShape);
    }
    if (event is HideFocusEvent) {
      // yield state.copyWith(hideFocusShape: event.focusShape);
    }
    if (event is LeftRotationEvent) {
      yield state.copyWith(rotationLeft: true);
    }
    if (event is RightRotationEvent) {
      yield state.copyWith(rotationRight: true);
    }
  }

  @override
  void onTransition(Transition<SolverEvent, SolverState> transition) {
    super.onTransition(transition);
   // log.d('****onTransition***\nstate:${transition.nextState}');
  }
}
