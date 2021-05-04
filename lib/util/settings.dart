import 'package:flutter/material.dart';
import 'package:tangram/util/shape_enum.dart';


class Settings {
  //-- how many points
  final int boardWidth; //9
  final int boardHeight; //12

  //-- pointSize is a rectangle which consists of 4 triangles
  final int pointSize;

  //--- area for covering the shape, whole screen or MediaQuery
  final int pixelWidth;
  final int pixelHeight;

  //color of shapes WidgetGridLines
  final Color color;

  const Settings({
    required this.pixelWidth,
    required this.pixelHeight,
    this.boardWidth = 9,
    this.color = Colors.green,
  })  : pointSize = pixelWidth ~/ boardWidth,
        boardHeight = (pixelHeight ~/ (pixelWidth / boardWidth));

  /// [pixelWidth]%[boardWidth] to calculate alignment
  Offset get leftOver => Offset(0, 0);
}

double getBoardSize({required Shapes shape}) {
  double toReturn;
  switch (shape) {
    case Shapes.TriangleRed:
    case Shapes.TriangleBlue:
    case Shapes.TriangleGreen:
      toReturn = 2;
      break;
    default:
      toReturn = 4;
      break;
  }
  return toReturn;
}

String getAssetPath({required Shapes shape}) {
  String toReturn;
  switch (shape) {
    case Shapes.TriangleRed:
      toReturn = "assets/triangle.png";
      break;
    case Shapes.TriangleBlue:
      toReturn = "assets/triangle.png";
      break;
    case Shapes.TriangleGreen:
      toReturn = "assets/triangle.png";
      break;
    case Shapes.Trapezoid:
      toReturn = "assets/trapez.png";
      break;
    case Shapes.RectWithTriangle:
      toReturn = "assets/rectangleWithTriangle.png";
      break;
    case Shapes.RectWithoutTriangle:
      toReturn = "assets/rectangleWithoutTriangle.png";
      break;
    default:
      toReturn = "";
      break;
  }
  return toReturn;
}
