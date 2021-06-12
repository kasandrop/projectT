import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/data/models/solver_helper.dart';
import 'package:tangram/util/logger.dart';

import 'solver.dart';

class SolverBloc extends Bloc<SolverEvent, SolverState> {
  final SolverHelper solverHelper;

  // final MovementsBloc movementsBloc;
  // StreamSubscription streamSubscription;

  SolverBloc({
    required this.solverHelper,
    // required this.movementsBloc,
  }) : super(SolverState(
            puzzleToSolvePoints: solverHelper.puzzleToSolvePoints,
            currentlyCoveredPuzzle: solverHelper.initMap(),
            solved: false,
            pointsToPack: solverHelper.length,
            pointsCovered: 0)) {
    //  streamSubscription=movementsBloc.stream.listen(() { })
  }

  @override
  Stream<SolverState> mapEventToState(SolverEvent event) async* {
    if (event is ShapeStartedDragDataEvent) {
      // log.d('after shapeStarted  state: $state');
      yield state.copyWithShapeStartedDragData(
          offset: event.offset, points: event.points);
    }
    if (event is ShapeFinishedDragDataEvent) {
      yield state.copyWithShapeFinishedDragData(
          offset: event.offset, points: event.points);
    }

    if (event is ShapeStartedRotation) {
      log.d('event${event.offset}, points: ${event.points}');
      yield state.copyWithShapeStartedDragData(
          offset: event.offset, points: event.points);
    }

    if (event is ShapeFinishedRotation) {
      log.d('event${event.offset}, points: ${event.points}');
      yield state.copyWithShapeFinishedDragData(
          offset: event.offset, points: event.points);
    }
  }

  @override
  void onTransition(Transition<SolverEvent, SolverState> transition) {
    super.onTransition(transition);
    // log.d('after shapeFinished  state: ${transition.nextState}');
  }
}
