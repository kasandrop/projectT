import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:triangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:triangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:triangram/data/models/shapeProduct/trapezoid.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/util/shape_enum.dart';

import 'constants.dart';
import 'grid_enum.dart';
import 'logger.dart';

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

//how many points across the board, ex. triangle has 2 points
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

double screenHeight(BuildContext context, {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

double horizontalAlignment({required BuildContext context, required double widthToAlign}) =>
    (screenSize(context).width - widthToAlign) / 2;

double screenHeightExcludingToolbar(BuildContext context, {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

Size getSizeFromShape(Shapes shape) {
  var size;
  switch (shape) {
    case Shapes.Trapezoid:
      size = Trapezoid.shapeSize;
      break;
    case Shapes.TriangleGreen:
    case Shapes.TriangleBlue:
    case Shapes.TriangleRed:
      size = Triangle.shapeSize;
      break;
    case Shapes.RectWithoutTriangle:
      size = RectWithoutTriangle.shapeSize;
      break;

    case Shapes.RectWithTriangle:
      size = RectWithTriangle.shapeSize;
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

//aligns a shape to a puzzle if the shape is inside and is dropped close enough to the puzzle
Offset normalizeOffset({
  required Offset boundingRect,
  required List<Offset> pointsPath,
  required List<Offset> pointsOfShape,
}) {
  log.d('------------normalizeOffset,,,,,normalizeOffset ');
  var lackOfPrecisionOffset = Offset(lackOfPrecision, lackOfPrecision);

  var newOffset = Offset(boundingRect.dx.round().toDouble(), boundingRect.dy.round().toDouble());
  var difference = newOffset - boundingRect;
  var absOffset = offsetAbs(difference);
  log.d(
      ' what is absOffset > lackOfPrecisionOffset: ${absOffset.toStringAsFixed(5)} > ${lackOfPrecisionOffset.toStringAsFixed(5)}');
  if (absOffset.dx > lackOfPrecisionOffset.dx || absOffset.dy > lackOfPrecisionOffset.dy) {
    log.d('returning: $boundingRect');
    return boundingRect;
  }

  var path = Path();
  path.addPolygon(pointsPath, true);
  var isPointInside = pointsOfShape.every((point) {
    var res = path.contains(point + difference + boundingRect);
    log.d('($point + $difference + $boundingRect) is inside path?->$res');

    return res;
  });

  if (isPointInside == true) {
    log.d('returning:${newOffset.toStringAsFixed(5)}');
    return newOffset;
  } else {
    log.d('isPointInside=$isPointInside');
    return boundingRect;
  }
}

Offset offsetAbs(Offset offset) => Offset(offset.dx.abs(), offset.dy.abs());

extension OffsetParsing on Offset {
  String toStringAsFixed(int l) {
    return 'Offset (${dx.toStringAsFixed(5)},${dy.toStringAsFixed(5)})';
  }
}
