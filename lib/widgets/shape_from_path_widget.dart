import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:triangram/widgets/shape_painter.dart';
import 'package:triangram/widgets/shapes/shape_border/triangle_shape_border.dart';

class ShapeFromPathWidget extends StatelessWidget {
  final Size size;
  final Color color;
  final Color shadowColor;
  final Path path;
  final bool visibility;
  //final double elevation;
  final DraggableState state;

  const ShapeFromPathWidget({
    Key? key,
    required this.size,
    required this.color,
    //required this.elevation,
    required this.shadowColor,
    required this.path,
    required this.state,
    this.visibility = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visibility,
        child: CustomPaint(
          size: size,
          painter: ShapePainter(
            state: state,
            // elevation: elevation,
            shadowColor: shadowColor,
            path: path,
            color: color,
          ),
        ));
  }
}

/*
class ShapeFromPathWidget1 extends StatelessWidget {
  final Size size;
  final Color color;
  final Color shadowColor;
  final Path path;
  final bool visibility;
  final double elevation;

  const ShapeFromPathWidget1({
    Key? key,
    required this.size,
    required this.color,
    required this.elevation,
    required this.shadowColor,
    required this.path,
    this.visibility = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Material(
          elevation: 5,
          type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          color: color,
          shape: TriangleShape(
            colorShadow: shadowColor,
            color: color,
            path: path,
          )),
    );
  }
}
*/
enum DraggableState { dragged, focused, enabled, none }
