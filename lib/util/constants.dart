import 'package:flutter/material.dart';

const String shapesRectWithTriangle = 'assets/rectangleWithTriangle.png';
const String shapesRectWithoutTriangle = 'assets/rectangleWithoutTriangle.png';
const String shapesTriangleGreen = 'assets/triangle.png';
const String shapesTriangleRed = 'assets/triangle.png';
const String shapesTriangleBlue = 'assets/triangle.png';
const String shapesTrapezoid = 'assets/trapez.png';
const kDarkGrey=Color(0xFF363636);
const kLightGrey=Colors.white38;
const kColorOfPuzzle=Colors.red;
const kColorBlue = Color(0xFF4A81B0);
const kColorGreen = Color(0xFF4CAF50);
const kColorOrange = Color(0xFFFF9800);
const httpAddress =
    "https://gamepoints-b963b-default-rtdb.europe-west1.firebasedatabase.app/root.json";
const int boardWidth=10;

class Routes {
  static const String home = '/';
  static const String error = '/error';
  static const String game = '/game';
}