import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/util/grid_enum.dart';

class Level extends Equatable {
  Level({
    required this.grid,
    required this.points,
  });

  final Grid grid;
  final List<Offset> points;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        grid: Grid.values.elementAt(json["grid"]),
        points: List.from(json["offset"].map((x) =>Offset((x["dx"]).toDouble(), (x["dy"]).toDouble()))),
      );

  Map<String, dynamic> toJson() => {
        "grid": grid.index,
        "offset": List<dynamic>.from(points.map((Offset x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [grid, points];
}




extension OffsetToJson on Offset {
  Map<String, dynamic> toJson() => {"dx": this.dx, "dy": this.dy};
}
/*

  factory PointSystem.fromJson(Map<String, dynamic> json) {
    return PointSystem(
      dx: json['dx'],
      dy: json['dy'],
      east: json['east'] ?? true,
      west: json['west'] ?? true,
      south: json['south'] ?? true,
      north: json['north'] ?? true,
    );
  }






 Map<String, dynamic> toJson() => {
        "dx": dx,
        "dy": dy,
        "east": east,
        "west": west,
        "south": south,
        "north": north,
      };
 */
