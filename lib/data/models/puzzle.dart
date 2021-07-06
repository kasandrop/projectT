import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Puzzle extends Equatable {
  final List<Offset> points;

  // late final Offset widthSpread;
  // late final Offset heightSpread;

  Puzzle({
    required this.points,
  });

  @override
  List<Object> get props => [points];

  Puzzle.zero() : points = <Offset>[];

  void _init() {
    var _tempWidthSpread;
    var _tempHeightSpread;
    points.forEach((element) {
      if (element == points.first) {
        _tempWidthSpread = Offset(element.dx.toDouble(), element.dy.toDouble());
        _tempHeightSpread = Offset(element.dx.toDouble(), element.dy.toDouble());
      }

      var tempX = element.dx;
      if (tempX < _tempWidthSpread.dx) {
        _tempWidthSpread = Offset(tempX.toDouble(), _tempWidthSpread.dy);
      }
      if (tempX > _tempWidthSpread.dy) {
        _tempWidthSpread = Offset(_tempWidthSpread.dx, tempX.toDouble());
      }

      var tempY = element.dy;
      if (tempY < _tempHeightSpread.dx) {
        _tempHeightSpread = Offset(tempY.toDouble(), _tempHeightSpread.dy);
      }
      if (tempY > _tempHeightSpread.dy) {
        _tempHeightSpread = Offset(_tempHeightSpread.dx, tempY.toDouble());
      }
    });

    // heightSpread = Offset(_tempHeightSpread.dx, _tempHeightSpread.dy);

    // widthSpread = Offset(_tempWidthSpread.dx, _tempWidthSpread.dy);
  }

  //unit data
  Path getPath({double pointSize = 1}) {
    var path = Path()
      ..addPolygon(points, true);
    if (pointSize == 1) {
      return path;
    }
    var matrix4 = Matrix4.identity();
    matrix4.scale(pointSize, pointSize);
    return path.transform(matrix4.storage);
  }
}