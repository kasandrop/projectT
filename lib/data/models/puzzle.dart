import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Puzzle extends Equatable {
  final List<Offset> _points;
  late final Offset puzzleOffset;

  Puzzle(this._points);

  List<Offset> pointsAfterAlignment() => _points.map((e) => e + puzzleOffset).toList();

  @override
  List<Object> get props => [_points];

  Puzzle.zero() : _points = <Offset>[];

  @override
  bool get stringify => true;

  Path getPathAfterAlignment() => Path()..addPolygon(pointsAfterAlignment(), true);

  Path getPathForUi({double pointSize = 1}) {
    var path = Path()..addPolygon(_points, true);
    if (pointSize == 1) {
      return path;
    }
    var matrix4 = Matrix4.identity();
    matrix4.scale(pointSize, pointSize);
    return path.transform(matrix4.storage);
  }
}
