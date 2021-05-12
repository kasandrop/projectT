import 'package:flutter/material.dart';

class PointSystem {
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

  //100% correctf
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

  @override
  String toString() {
    return 'PointSystem{dx: $dx, '
        'dy: $dy,\n north: $north  \n, east: $east  \n, south: $south  \n, west: $west \n}';
  }
}

//  |-----------|
//  |'    N   ' |3
//    W ' ' E   |2
//  |     S     |1
//  |___________|0 1 2 3 4
//              -1
//              -2
