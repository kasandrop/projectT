import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/business/solver_helper.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/point_system.dart';

part 'solver_event.dart';

part 'solver_state.dart';

class SolverBloc extends Bloc<SolverEvent, SolverState> {
  final List<PointSystem> puzzleToSolvePoints;
  final SolverHelper solverHelper;

  SolverBloc({
    required this.puzzleToSolvePoints,
    required this.solverHelper,
    //required this.solved,
  }) : super(SolverState(
            puzzleToSolvePoints: puzzleToSolvePoints,
            currentlyCoveredPuzzle: solverHelper.initMap(puzzleToSolvePoints),
            solved: false,
            pointsToPack: puzzleToSolvePoints.length,
            pointsCovered: 0));

  @override
  Stream<SolverState> mapEventToState(SolverEvent event) async* {
    if (event is ShapeStartedDragDataEvent) {
      yield state.copyWithShapeStartedDragData(
          offset: event.offset, points: event.points);
    }
    if (event is ShapeFinishedDragDataEvent) {
      yield state.copyWithShapeFinishedDragData(
          offset: event.offset, points: event.points);
    }
  }

  @override
  void onTransition(Transition<SolverEvent, SolverState> transition) {
    super.onTransition(transition);
    log.d('points covered: ${transition.currentState.pointsCovered}'
        'from ${transition.currentState.pointsToPack}');
  }
}
