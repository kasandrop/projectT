import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'level.dart';

/// level : [{"grid":1,"offset":[{"dx":1,"dy":1}]},{"grid":1,"offset":[{"dx":2,"dy":2}]},{"grid":1,"offset":[{"dx":3,"dy":2}]}]

class Levels extends Equatable {
  final List<Level> levels;


  Levels({required this.levels});

  int get numberOfLevels => levels.length;


  //Level getLevel(int number) => level.elementAt(number - 1);

  factory Levels.fromJson(Map<String, dynamic> json) => Levels(
        levels: List<Level>.from(json["level"].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": List<dynamic>.from(levels.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [levels];
}
