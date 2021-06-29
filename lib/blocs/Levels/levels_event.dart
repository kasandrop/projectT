import 'dart:ui';

abstract class LevelsEvent {
  const LevelsEvent();
}

class CurrentLevel extends LevelsEvent {
    final int levelPosition;


  const CurrentLevel({required this.levelPosition}) : super();
}

