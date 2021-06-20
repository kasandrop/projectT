import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tangram/data/models/point_system.dart';

import 'constants.dart';
import 'grid_enum.dart';

Path pointSystemsToPath(List<PointSystem> points, double pointSize) {
  var path = Path();
  points.forEach((element) {
    path.addPath(_pointSystemToPath(element, pointSize), Offset(0, 0));
  });
  return path;
}

double pointSizeFromContext(BuildContext context) {
  return _pointSize(screenSize(context), Grid.Normal);
}

double _pointSize(Size sizeOfTheScreenPixel, Grid currentLevelGrid) {
  if (currentLevelGrid == Grid.Normal) {
    return (sizeOfTheScreenPixel.width ~/ boardWidth).toDouble();
  }
  var _temp = sizeOfTheScreenPixel.width ~/ boardWidth;
  var _sqrt = math.sqrt(math.pow(_temp, 2) + math.pow(_temp, 2));
  return _sqrt;
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

double screenHeightExcludingToolbar(BuildContext context, {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

Path _pointSystemToPath(PointSystem pointSystem, double pointSize) {
  var path = Path();
  var startX = pointSystem.dx.toDouble() * pointSize;
  var startY = pointSystem.dy.toDouble() * pointSize;
  var middleX = startX + pointSize / 2;
  var middleY = startY + pointSize / 2;

  if (pointSystem.east == true &&
      pointSystem.north == true &&
      pointSystem.south == true &&
      pointSystem.west == true) {
    path.moveTo(startX, startY);
    path.lineTo(startX + pointSize, startY);
    path.lineTo(startX + pointSize, startY + pointSize);
    path.lineTo(startX, startY + pointSize);
    path.close();
    return path;
  }
  if (pointSystem.east == true) {
    var tempPath = Path();
    tempPath.moveTo(middleX, middleY);
    tempPath.lineTo(startX + pointSize, startY);
    tempPath.lineTo(startX + pointSize, startY + pointSize);
    tempPath.close();
    path.addPath(tempPath, Offset.zero);
  }
  if (pointSystem.south == true) {
    var tempPath = Path();
    tempPath.moveTo(middleX, middleY);
    tempPath.lineTo(startX + pointSize, startY + pointSize);
    tempPath.lineTo(startX, startY + pointSize);
    tempPath.close();
    path.addPath(tempPath, Offset.zero);
  }
  if (pointSystem.west == true) {
    var tempPath = Path();
    tempPath.moveTo(middleX, middleY);
    tempPath.lineTo(startX, startY);
    tempPath.lineTo(startX, startY + pointSize);

    tempPath.close();
    path.addPath(tempPath, Offset.zero);
  }
  if (pointSystem.north == true) {
    var tempPath = Path();
    tempPath.moveTo(middleX, middleY);
    tempPath.lineTo(startX, startY);
    tempPath.lineTo(startX + pointSize, startY);
    tempPath.close();

    path.addPath(tempPath, Offset.zero);
  }
  return path;
}
