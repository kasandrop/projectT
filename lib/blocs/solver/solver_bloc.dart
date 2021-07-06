import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/blocs/solver/solver.dart';
import 'package:tangram/util/shape_enum.dart';

class SolverBloc extends Bloc<SolverEvent, SolverState> {
  final Map<Shapes, Path> map;
  final Path puzzlePath;

  SolverBloc({
    required this.map,
    required this.puzzlePath,
  }) : super(SolverState(puzzlePath: puzzlePath, map: map));

  @override
  Stream<SolverState> mapEventToState(SolverEvent event) async* {
    if (event is UpdateMapEvent) {
      yield state.copyWith(map: event.map,freshData:true);
    }
    if (event is NoFreshUpdatesEvent) {
      yield state.copyWith(freshData: false);
    }
  }

  @override
  void onTransition(Transition<SolverEvent, SolverState> transition) {
    super.onTransition(transition);
  }
}
