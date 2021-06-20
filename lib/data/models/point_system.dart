import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PointSystem extends Equatable {
  final int dx;
  final int dy;
  final bool north;
  final bool east;
  final bool south;
  final bool west;

  const PointSystem({
    required this.dx,
    required this.dy,
    this.north = true,
    this.east = true,
    this.south = true,
    this.west = true,
  });

  /*
     PointSystem  ps is about to get  rotated.
   */
  Offset getOffset() {
    return Offset(dx.toDouble(), dy.toDouble());
  }

  //100% correct
  PointSystem.afterClockWiseRotation(
      {required PointSystem ps, required dx, required this.dy})
      : north = ps.west,
        east = ps.north,
        south = ps.east,
        west = ps.south,
        dx = dx -
            1; //clockwise rotation will move top left of the point to become top right

  const PointSystem.zero({required this.dx, required this.dy})
      : north = false,
        east = false,
        south = false,
        west = false;

  const PointSystem.north({required this.dx, required this.dy})
      : north = true,
        east = false,
        south = false,
        west = false;

  const PointSystem.west({required this.dx, required this.dy})
      : north = false,
        east = false,
        south = false,
        west = true;

  const PointSystem.east({required this.dx, required this.dy})
      : north = false,
        east = true,
        south = false,
        west = false;

  const PointSystem.south({required this.dx, required this.dy})
      : north = false,
        east = false,
        south = true,
        west = false;

  @override
  String toString() {
    return 'PointSystem{dx: $dx, '
        'dy: $dy,\n north: $north  \n, east: $east  \n, south: $south  \n, west: $west \n}';
  }

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

  PointSystem operator +(Offset offset) => PointSystem(
      dx: dx + offset.dx.toInt(),
      dy: dy + offset.dy.toInt(),
      west: west,
      south: south,
      east: east,
      north: north);

  @override
  List<Object?> get props => [dx, dy, west, south, east, north];
}


// Offset operator +(Offset other) => Offset(dx + other.dx, dy + other.dy);
//  |-----------|
//  |'    N   ' |-3
//    W ' ' E   |-2
//  |     S     |-1
//  |___________  0 1 2 3 4
//                1
//                2
// class PointSystem {
//   int? dx;
//   int? dy;
//
//   PointSystem({
//     this.dx,
//     this.dy});
//
//
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["dx"] = dx;
//     map["dy"] = dy;
//     return map;
//   }
//
// }
