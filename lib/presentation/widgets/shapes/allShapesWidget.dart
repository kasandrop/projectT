import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/shapes.dart';
import 'package:tangram/presentation/widgets/shapes/shapesWidget.dart';
import 'package:tangram/settings.dart';

class AllShapesWidget extends StatelessWidget {
  final Settings settings;

  const AllShapesWidget({
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      TrapezoidWidget(
          trapezoid: Trapezoid(
            x: 1,
            y: 5,
          ),
          color: settings.color,
          settings: settings),
      TriangleWidget(
          color: settings.color, settings: settings, triangle: Triangle(x: 0, y: 1)),
      TriangleWidget(
          color: settings.color, settings: settings, triangle: Triangle(x: 3, y: 1)),
      TriangleWidget(
          color: settings.color, settings: settings, triangle: Triangle(x: 6, y: 1)),
      RectangleWithTriangleWidget(
          color: settings.color,
          settings: settings,
          rectangleWithTriangle: RectangleWithTriangle(x: 4, y: 5)),
      RectangleWithoutTriangleWidget(
          color: settings.color,
          settings: settings,
          rectangleWithoutTriangle: RectangleWithoutTriangle(x: 4, y: 7)),
    ]);
  }
}
