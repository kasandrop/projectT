import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:tangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:tangram/data/models/shapeProduct/trapezoid.dart';
import 'package:tangram/data/models/shapeProduct/triangle.dart';
import 'package:tangram/util/shape_enum.dart';

import 'constants.dart';
import 'grid_enum.dart';

// Path offsetsToPath(List<Offset> points, double pointSize) {
//   var path = Path();
//   var offset;
//
//   points.forEach((element) {
//     element == points.first
//         ? path.moveTo(element.dx, element.dy)
//         : path.lineTo(element.dx, element.dy);
//   });
//   path.close();
//   return path;
// }

//how many points acrross the board, ex. triangle has 2 points
double pointSizeFromContext(BuildContext context, [int? boardNumber]) {
  if (boardNumber == null) {
    return _pointSize(
      screenSize(context),
      Grid.Normal,
    );
  } else {
    return _pointSize(screenSize(context), Grid.Normal, boardNumber);
  }
}

double _pointSize(Size sizeOfTheScreenPixel, Grid currentLevelGrid,
    [int boardNumber = boardWidth]) {
  if (currentLevelGrid == Grid.Normal) {
    return (sizeOfTheScreenPixel.width ~/ boardNumber).toDouble();
  }
  var _temp = sizeOfTheScreenPixel.width ~/ boardNumber;
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

double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

Size getSizeFromShape(Shapes shape) {
  var size;
  switch (shape) {
    case Shapes.Trapezoid:
      size = Trapezoid.cellSize;
      break;
    case Shapes.TriangleGreen:
    case Shapes.TriangleBlue:
    case Shapes.TriangleRed:
      size = Triangle.cellSize;
      break;
    case Shapes.RectWithoutTriangle:
      size = RectWithoutTriangle.cellSize;
      break;

    case Shapes.RectWithTriangle:
      size = RectWithTriangle.cellSize;
      break;
    default:
      size = Size(0, 0);
  }
  return size;
}

Offset getOffsetFromContext({
  required BuildContext context,
}) {
  var rb = context.findRenderObject() as RenderBox;
  return rb.localToGlobal(rb.semanticBounds.topLeft);
}
