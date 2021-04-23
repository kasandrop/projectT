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
      // TrapezoidWidget(
      //     trapezoid: Trapezoid(x: 1, y: 5), color: settings.color, settings: settings),
      TriangleWidget(
          x: 0, y: 1, color: settings.color, settings: settings, baseShape: Triangle()),
      TriangleWidget(
          x: 4, y: 3, color: settings.color, settings: settings, baseShape: Triangle()),

      // Draggable(
      //     feedback: Container(
      //         height: settings.pointSize * 2,
      //         width: settings.pointSize * 2,
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             fit: BoxFit.fill,
      //             image: AssetImage("assets/triangle.png"),
      //           ),
      //         )),
      //     child: TriangleWidget(
      //         x: 1,
      //         y: 4,
      //         color: settings.color,
      //         settings: settings,
      //         baseShape: Triangle())),

      // RectangleWithTriangleWidget(
      //     color: settings.color,
      //     settings: settings,
      //     rectangleWithTriangle: RectangleWithTriangle(x: 4, y: 5)),
      // RectangleWithoutTriangleWidget(
      //     color: settings.color,
      //     settings: settings,
      //     rectangleWithoutTriangle: RectangleWithoutTriangle(x: 4, y: 7)),
    ]);
  }
}
