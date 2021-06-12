import 'package:flutter/material.dart';
import 'package:tangram/util/shape_enum.dart';

class GetInitialPositionsUseCase {
  final Map<Shapes, Offset> positionsMap = const <Shapes, Offset>{
    Shapes.Trapezoid: Offset(0, 0),
    Shapes.TriangleBlue: Offset(0, 0),
    Shapes.TriangleRed: Offset(0, 0),
    Shapes.TriangleGreen: Offset(0, 0),
    Shapes.RectWithoutTriangle: Offset(0, 0),
    Shapes.RectWithTriangle: Offset(0, 0)
  };

  const GetInitialPositionsUseCase();
}
