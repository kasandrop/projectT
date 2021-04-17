import 'package:flutter/material.dart';

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
        boardHeight = pixelHeight ~/ (pixelWidth / boardWidth);

  @override
  String toString() {
    return 'Settings{boardWidth: $boardWidth, boardHeight: $boardHeight, '
        'pointSize: $pointSize, '
        'pixelWidth: $pixelWidth, pixelHeight: $pixelHeight}';
  }
}
