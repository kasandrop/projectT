import 'dart:ui';

import 'package:tangram/data/models/point_system.dart';

class Puzzle {
  final List<PointSystem> pointsSystem;
  Offset get heightSpread => Offset(_tempHeightSpread.dx, _tempHeightSpread.dy);

  Offset get widthSpread => Offset(_tempWidthSpread.dx, _tempWidthSpread.dy);

  var _tempWidthSpread;
  var _tempHeightSpread;


  Puzzle({
    required this.pointsSystem,
  }) {
    _init();
  }

  Puzzle.zero():pointsSystem=<PointSystem>[];


  void _init() {
    pointsSystem.forEach((element) {
      if (element == pointsSystem.first) {
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
  }

  Path getPath(double pointSize) {
    var path = Path();
    pointsSystem.forEach((element) {
      path.addPath(_pointSystemToPath(element, pointSize), Offset(0, 0));
    });
    return path;
  }

  static Path _pointSystemToPath(PointSystem element, double pointSize) {
    var path = Path();

    var startX = element.dx.toDouble() * pointSize;
    var startY = element.dy.toDouble() * pointSize;
    var middleX = startX + pointSize / 2;
    var middleY = startY + pointSize / 2;

    if (element.east == true &&
        element.north == true &&
        element.south == true &&
        element.west == true) {
      path.moveTo(startX, startY);
      path.lineTo(startX + pointSize, startY);
      path.lineTo(startX + pointSize, startY + pointSize);
      path.lineTo(startX, startY + pointSize);
      path.close();
      return path;
    }
    if (element.east == true) {
      var tempPath = Path();
      tempPath.moveTo(middleX, middleY);
      tempPath.lineTo(startX + pointSize, startY);
      tempPath.lineTo(startX + pointSize, startY + pointSize);
      tempPath.close();
      path.addPath(tempPath, Offset.zero);
    }
    if (element.south == true) {
      var tempPath = Path();
      tempPath.moveTo(middleX, middleY);
      tempPath.lineTo(startX + pointSize, startY + pointSize);
      tempPath.lineTo(startX, startY + pointSize);
      tempPath.close();
      path.addPath(tempPath, Offset.zero);
    }
    if (element.west == true) {
      var tempPath = Path();
      tempPath.moveTo(middleX, middleY);
      tempPath.lineTo(startX, startY);
      tempPath.lineTo(startX, startY + pointSize);

      tempPath.close();
      path.addPath(tempPath, Offset.zero);
    }
    if (element.north == true) {
      var tempPath = Path();
      tempPath.moveTo(middleX, middleY);
      tempPath.lineTo(startX, startY);
      tempPath.lineTo(startX + pointSize, startY);
      tempPath.close();

      path.addPath(tempPath, Offset.zero);
    }

    return path;
  }
}
