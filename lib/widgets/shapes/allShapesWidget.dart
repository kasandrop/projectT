import 'package:flutter/material.dart';
import 'package:tangram/businessLogic/shapes/shapes.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/widgets/shapes/shapesWidget.dart';

class AllShapesWidget extends StatelessWidget {
  final Settings settings;

  const AllShapesWidget({
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: settings.pixelHeight.toDouble(),
          width: settings.pixelWidth.toDouble(),
          child: TrapezoidWidget(
            trapezoid: Trapezoid(
              x: 1,
              y: 5,
            ),
            color: settings.color,
            settings: settings,
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: settings.pixelHeight.toDouble(),
          width: settings.pixelWidth.toDouble(),
          child: TriangleWidget(
            color: settings.color,
            settings: settings,
            triangle: Triangle(
              x: 0,
              y: 1,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: settings.pixelHeight.toDouble(),
          width: settings.pixelWidth.toDouble(),
          child: TriangleWidget(
            color: settings.color,
            settings: settings,
            triangle: Triangle(
              x: 3,
              y: 1,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: settings.pixelHeight.toDouble(),
          width: settings.pixelWidth.toDouble(),
          child: TriangleWidget(
            color: settings.color,
            settings: settings,
            triangle: Triangle(
              x: 6,
              y: 1,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: settings.pixelHeight.toDouble(),
          width: settings.pixelWidth.toDouble(),
          child: RectangleWithTriangleWidget(
            color: settings.color,
            settings: settings,
            rectangleWithTriangle: RectangleWithTriangle(
              x: 4,
              y: 5,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: settings.pixelHeight.toDouble(),
          width: settings.pixelWidth.toDouble(),
          child: RectangleWithoutTriangleWidget(
            color: settings.color,
            settings: settings,
            rectangleWithoutTriangle: RectangleWithoutTriangle(
              x: 4,
              y: 7,
            ),
          ),
        ),
      ),
    ]);
  }
}
