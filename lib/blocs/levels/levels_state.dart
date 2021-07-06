import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/data/models/level.dart';
import 'package:tangram/data/models/levels.dart';
import 'package:tangram/util/grid_enum.dart';

//-----------------------------------------------------------------
@immutable
class LevelsState extends Equatable {
  final Levels levels;
  final int currentLevelNumber;


  // final Offset size; //pixelHeight,pixelWidth  or real screen size in pixel

  const LevelsState({
    required this.currentLevelNumber,
    required this.levels,
  }) : super();

  Level get currentLevel => levels.levels.elementAt(currentLevelNumber);

  int get numberOfLevels => levels.numberOfLevels;

  Grid get currentLevelGrid => currentLevel.grid;

  Puzzle get puzzle {

    return Puzzle(points: currentLevel.points
    );
  }

  List<Offset>? get points => currentLevel.points;

  LevelsState copyWith({
    Levels? levels,
    int? currentLevelNumber,
  }) {
    return LevelsState(
      currentLevelNumber: currentLevelNumber ?? this.currentLevelNumber,
      levels: levels ?? this.levels,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [levels, currentLevelNumber];
}
