import 'package:flutter/material.dart';

const String shapesRectWithTriangle = 'assets/rectangleWithTriangle.png';
const String shapesRectWithoutTriangle = 'assets/rectangleWithoutTriangle.png';
const String shapesTriangleGreen = 'assets/triangle.png';
const String shapesTriangleRed = 'assets/triangle.png';
const String shapesTriangleBlue = 'assets/triangle.png';
const String shapesTrapezoid = 'assets/trapez.png';
const kDarkerGrey = Color(0xFF222222);
const kDarkGrey = Color(0xFF363636);
const kLightGrey = Colors.white38;
const kColorOfPuzzle = Colors.red;
const kColorBlue = Color(0xFF4A81B0);
const kColorGreen = Color(0xFF4CAF50);
const kColorOrange = Color(0xFFFF9800);

const kColorBlueLight = Color(0xFF00FFCC);
const kColorBlueDark = Color(0xFFD42AFF);

const kColorPinkLight = Color(0xFFFFCC00);
const kColorPinkDark = Color(0xFFD42AFF);

const kColorRedLight = Color(0xFFFF34FF);
const kColorRedDark = Color(0xFFD40000);

const kColorOrangeLight = Color(0xFFFFCC00);
const kColorOrangeDark = Color(0xFFFF0000);

const kColorGreenLight = Color(0xFF87DECD);
const kColorGreenDark = Color(0xFF008066);

const kColorBlueLighter = Color(0xFF00FFCC);
const kColorBlueDarker = Color(0xFF2A7FFF);

const kColorYellowPinkLight = Color(0xFFFF00FF);
const kColorYellowPinkDark = Color(0xFF1AB7EA);
const httpAddress =
    "https://gamepoints-b963b-default-rtdb.europe-west1.firebasedatabase.app/root.json";
const int boardWidth = 10;
const lackOfPrecision = 0.4;

class Routes {
  static const String home = '/';
  static const String error = '/error';
  static const String game = '/game';
}

final Color primaryColor = Color(0xFFBB86FC);
final Color primaryVariant = Color(0xFF3700B3);
final Color secondary = Color(0xFF03DAC5);
final Color secondaryVariant = Color(0xFFF2C6A0);
final Color surface = Color(0xFF121212);
final Color background = Color(0xFF121212);
final Color error = Color(0xFFCF6679);
final Color onPrimary = Color(0xFF000000);
final Color onSecondary = Color(0xFF000000);
final Color onSurface = Color(0xFFFFFFFF);
final Color onBackground = Color(0xFFFFFFFF);
final Color onError = Color(0xFF000000);
final Brightness brightness = Brightness.dark;

ColorScheme colorSchemeDark = ColorScheme.dark(
  background: background,
  brightness: brightness,
  error: error,
  primary: primaryColor,
  primaryVariant: primaryVariant,
  secondary: secondary,
  secondaryVariant: secondaryVariant,
  surface: surface,
  onBackground: onBackground,
  onError: onError,
  onPrimary: onPrimary,
  onSecondary: onSecondary,
  onSurface: onSurface,
);

class AppTheme {
  static const int themeLight = 1;
  static const int themeDark = 2;
}
