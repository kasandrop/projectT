import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triangram/data/useCases/get_levels_use_case.dart';
import 'package:triangram/util/logger.dart';

import 'levels.dart';

class LevelsBloc extends Bloc<LevelsEvent, LevelsState> {
  final GetLevelsUseCase getLevelsUseCase;
  final int lastLevelCompleted;
  final LevelsState initialState;

  LevelsBloc({
    required this.getLevelsUseCase,
    required this.lastLevelCompleted,
    required this.initialState,
  }) : super(initialState);

  @override
  Stream<LevelsState> mapEventToState(LevelsEvent event) async* {
    if (event is CurrentLevel) {
      yield state.copyWith(
        currentLevelNumber: event.levelPosition,
        levels: state.levels,
      );
    }
  }
}
