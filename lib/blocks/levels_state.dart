import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/data/models/level.dart';
import 'package:tangram/data/models/levels.dart';
import 'package:tangram/data/models/point_system.dart';

class LevelsState  extends Equatable{

  late final Levels levels;
  late final int currentLevelNumber;

   Level get currentLevel=>levels.level.elementAt(currentLevelNumber);
   List<PointSystem>   get pointSystem=>currentLevel.pointSystem;


  @override
  // TODO: implement props
  List<Object?> get props => [];

}