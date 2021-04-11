import 'package:flutter/material.dart';

class Settings {
  //-- how many points
  final int boardWidth; //8
  final int boardHeight;

  //-- pointSize is e rectangle whi9ch consists of 4 triangles
  final int pointSize;

  //--- area for covering the shape
  final int pixelWidth;
  final int pixelHeight;

  //--- point in the middle of rectangle
  final Offset middlePoint;

  const Settings(
      {required this.pixelWidth, required this.pixelHeight, this.boardWidth = 8})
      : pointSize = pixelWidth ~/ boardWidth,
        boardHeight = pixelHeight ~/ (pixelWidth / boardWidth);

  @override
  String toString() {
    return 'Settings{boardWidth: $boardWidth, boardHeight: $boardHeight, pointSize: $pointSize, pixelWidth: $pixelWidth, pixelHeight: $pixelHeight}';
  }
}
