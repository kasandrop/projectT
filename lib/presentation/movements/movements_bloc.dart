import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/baseShape.dart';
import 'package:tangram/business/useCases/get_initial_positions__usecase.dart';
import 'package:tangram/business/useCases/MovingMechanismUseCase.dart';
import 'package:tangram/business/useCases/get_initial_rotation_points_usecase.dart';
import 'package:tangram/util/point_system.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/shape_enum.dart';

part 'movements_event.dart';

part 'movements_state.dart';

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
            positionsMap: Map.of(getInitialPositionsOfTheShapesUseCase.positionsMap),
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
  void onChange(Change<MovementsState> change) {
    super.onChange(change);
  //  log.d('after ...rotation : ${change.currentState.baseShapeMap[state.focusShape]!.points}....');
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
      BaseShape tempShape = state.baseShapeMap[state.focusShape]!;

      // getInitialRotationPointsUseCase.rotateShape(shape: state.focusShape);
     // log.d('before rotation : ${state.baseShapeMap[state.focusShape]!.points}');
      tempShape.rotateRight();
     // log.d('after ...rotation : ${state.baseShapeMap[state.focusShape]!.points}....');
   //   yield state;
      yield state.copyWith(baseShape: tempShape,delta:state.delta+Offset(0,0.001));
    }
    //==================================================================
    if (event is DragStarted) {
      //  log.i('$event');
      movingMechanismUseCase.pointSize = event.pointSize;
      yield state.copyWith(delta: Offset.zero);
    }
    //==================================================================
    if (event is ShapeDragged) {
      // log.d('${event.cumulativeDelta}');
      List<Offset> result = movingMechanismUseCase.changeStatePositionAndDelta(
          delta: event.delta + state.delta);
      Offset pos = result[0];
      Offset cumDelta = result[1];
      yield state.copyWith(
        delta: cumDelta,
        focusShape: state.focusShape,
        currentPosition: Offset(state.positionsMap[state.focusShape]!.dx + pos.dx,
            state.positionsMap[state.focusShape]!.dy + pos.dy),
      );
    }
    if (event is DraggedFinished) {
    //  log.d('after ...rotation : ${state.baseShapeMap[state.focusShape]!.points}....');
    }
  }
}
