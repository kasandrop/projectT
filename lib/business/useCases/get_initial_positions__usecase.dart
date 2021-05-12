import 'package:flutter/material.dart';
import 'package:tangram/util/shape_enum.dart';

class GetInitialPositionsUseCase {
  final Map<Shapes, Offset> positionsMap = const <Shapes, Offset>{
    Shapes.Trapezoid: Offset(6, 3),
    Shapes.TriangleBlue: Offset(0, 0),
    Shapes.TriangleRed: Offset(4, 0),
    Shapes.TriangleGreen: Offset(6, 0),
    Shapes.RectWithoutTriangle: Offset(5, 2),
    Shapes.RectWithTriangle: Offset(3, 7)
  };

  const GetInitialPositionsUseCase();
}
