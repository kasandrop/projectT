import 'package:equatable/equatable.dart';

import 'level.dart';

/// level : [{"grid":1,"pointSystem":[{"dx":1,"dy":1}]},{"grid":1,"pointSystem":[{"dx":2,"dy":2}]},{"grid":1,"pointSystem":[{"dx":3,"dy":2}]}]

class Levels extends Equatable {
  final List<Level> level;

  Levels({required this.level});

  int get numberOfLevels => level.length;

  Level getLevel(int number) => level.elementAt(number - 1);

  factory Levels.fromJson(Map<String, dynamic> json) => Levels(
        level: List<Level>.from(json["level"].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": List<dynamic>.from(level.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [level];
}

/// grid : 1
/// pointSystem : [{"dx":1,"dy":1}]

/// dx : 1
/// dy : 1
