import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triangram/blocs/solver/solver.dart';
import 'package:triangram/data/models/puzzle.dart';
import 'package:triangram/util/shape_enum.dart';

class SolverBloc extends Bloc<SolverEvent, SolverState> {
  final PathsForShapes pathsForShape;
  final Puzzle puzzle;

  SolverBloc({
    required this.pathsForShape,
    required this.puzzle,
  }) : super(SolverState(puzzle: puzzle, pathsForShapes: pathsForShape, attempt: 0));

  @override
  Stream<SolverState> mapEventToState(SolverEvent event) async* {
    if (event is UpdateMapEvent) {
      yield state.copyWith(pathsForShapes: PathsForShapes(map: event.map));
    }
  }
}
