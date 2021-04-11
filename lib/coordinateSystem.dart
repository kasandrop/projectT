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
}
//  |-----------|
//  |'    N   ' |3
//    W ' ' E   |2
//  |     S     |1
//  |___________|0 1 2 3 4
//              -1
//              -2
