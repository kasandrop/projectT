import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tangram/business/useCases/MovingMechanismUseCase.dart';
import 'package:tangram/business/useCases/get_initial_positions__usecase.dart';
import 'package:tangram/business/useCases/get_initial_rotation_points_usecase.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/point_system.dart';
import 'package:tangram/util/shape_enum.dart';

import 'movements.dart';

/// [baseShapeMap] every shape has his own List of [PointSystem]
// It allows  to track rotation of the shape.
//
//
//
//

class MovementsBloc extends Bloc<MovementsEvent, MovementsState> {
  final GetInitialRotationPointsUseCase getInitialRotationPointsUseCase;
  final MovingMechanismUseCase movingMechanismUseCase;
  final GetInitialPositionsUseCase getInitialPositionsOfTheShapesUseCase;

  MovementsBloc({
    required this.movingMechanismUseCase,
    required this.getInitialRotationPointsUseCase,
    required this.getInitialPositionsOfTheShapesUseCase,
  }) : super(
          MovementsState(
            baseShapeMap: Map.of(getInitialRotationPointsUseCase.getMap()),
            focusShape: Shapes.TriangleGreen,
            delta: Offset(0, 0),
            positionsMap:
                Map.of(getInitialPositionsOfTheShapesUseCase.positionsMap),
            rotation: false,
            dragFinished: false,
          ),
        );

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    log.wtf('$stackTrace');
  }

  @override
  void onEvent(MovementsEvent event) {
    super.onEvent(event);
   // log.d('$event');
  }

  @override
  void onTransition(Transition<MovementsEvent, MovementsState> transition) {
    super.onTransition(transition);
    // log.d('${transition.currentState}........................${transition.nextState}}');
  }

  @override
  Stream<MovementsState> mapEventToState(
    MovementsEvent event,
  ) async* {
    //==================================================================
    if (event is ShapeFocused) {
      //log.i('$state');
      yield state.copyWith(focusShape: event.focusShape, delta: Offset(0, 0));
    }
    //==================================================================
    if (event is RotatedRight) {
      log.d('Rotated right event');
      var tempShape = state.baseShapeMap[state.focusShape]!;
      tempShape.rotateRight();
      yield state.copyWith(
          baseShape: tempShape,
          rotation: true,
          delta: state.delta +
              Offset(0, 0.001)); //adding offset otherwise state not emitted
    }
    //==================================================================

    if (event is DraggingFinished) {
      yield state.copyWith(dragFinished: true);
    }
    //==================================================================
    if (event is DragStarted) {
      //  log.i('$event');
      movingMechanismUseCase.pointSize = event.pointSize;
      yield state.copyWith(delta: Offset.zero, dragFinished: false);
    }
    //==================================================================
    if (event is ShapeDragging) {
      // log.d('${event.cumulativeDelta}');
      var result = movingMechanismUseCase.changeStatePositionAndDelta(
          delta: event.delta + state.delta);
      var pos = result[0];
      var cumDelta = result[1];
      yield state.copyWith(
        delta: cumDelta,
        focusShape: state.focusShape,
        currentPosition: Offset(
            state.positionsMap[state.focusShape]!.dx + pos.dx,
            state.positionsMap[state.focusShape]!.dy + pos.dy),
      );
    }
  }
}
