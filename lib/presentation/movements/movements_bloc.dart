import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tangram/business/useCases/GetInitialPositionsOfTheShapes.dart';
import 'package:tangram/business/useCases/MovingMechanismUseCase.dart';
import 'package:tangram/business/useCases/get_initial_points.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/shape_enum.dart';

part 'movements_event.dart';

part 'movements_state.dart';

//  There are two goals of the point system.
//  1.goal: for render purpose. Not always whole rectangle is fully filled.
//
//  2 goal:they will make it easy to work out if the puzzle shape
//  is covered with my shapes
//
//  For every shape are read  initial points from GetInitialPointsUseCase->getMap()
//  then they are kept in a state memory.
//  During rotation points in GetPointsUseCase are rotated.
//  Then   _transformMap Function   replaces them in a state to reflect rotation.

// Now for the positions it is different ..
// They are all kept in a state. At  the initialization time
// they  are read from GetPointUseCase->getPositionsMap. All the time state tracks
// current positions of all the shapes.
//
//
class MovementsBloc extends Bloc<MovementsEvent, MovementsState> {
  final GetPointsUseCase getPointsUseCase;
  final Map<Shapes, List<PointSystem>> pointsMap;
  final MovingMechanismUseCase movingMechanismUseCase;
  final GetInitialPositionsOfTheShapesUseCase getInitialPositionsOfTheShapesUseCase;

  MovementsBloc({
    required this.movingMechanismUseCase,
    required this.getPointsUseCase,
    required this.getInitialPositionsOfTheShapesUseCase,
  })  : pointsMap = getPointsUseCase.getMap(),
        super(
          MovementsState(
            pointsMap: getPointsUseCase.getMap(),
            focusShape: Shapes.TriangleGreen,
            delta: Offset(0, 0),
            positionsMap: Map.of(GetInitialPositionsOfTheShapesUseCase.positionsMap),
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
    log.d('$event');
  }

  @override
  void onChange(Change<MovementsState> change) {
    super.onChange(change);
    log.d(' current state:${change.currentState}...............................'
        'nextState:${change.nextState}');
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
      getPointsUseCase.rotateShape(shape: state.focusShape);
      yield state.copyWith(
        pointsMap: _transformMap(
          pointsMap: state.pointsMap,
          listOfPoints: getPointsUseCase.getPoints(shape: state.focusShape),
        ),
      );
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
  }

  Map<Shapes, List<PointSystem>> _transformMap(
      {required Map<Shapes, List<PointSystem>> pointsMap,
      required List<PointSystem> listOfPoints}) {
    pointsMap[state.focusShape] = listOfPoints;
    return pointsMap;
  }
}
