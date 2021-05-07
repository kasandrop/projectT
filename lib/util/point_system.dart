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
  Offset getOffset(){
    return  Offset(this.dx.toDouble(),this.dy.toDouble());
  }

  //100% correctf
    PointSystem.afterClockWiseRotation({required PointSystem ps,required dx,required this.dy})
      : this.north = ps.west,
        this.east = ps.north,
        this.south = ps.east,
        this.west = ps.south,
        this.dx=dx-1;//clockwise rotation will move top left of the point to become top right

  const PointSystem.zero({required this.dx, required this.dy})
      : this.north = false,
        this.east = false,
        this.south = false,
        this.west = false;

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
