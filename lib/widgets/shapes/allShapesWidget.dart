import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:tangram/widgets/shapes/shapeWidget.dart';

class AllShapesWidget extends StatelessWidget {
  const AllShapesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height:screenHeight(context),
      child: Stack(
        children: <Widget>[
          // const ShapeWidget(color: colorBlue,   shape: Shapes.TriangleBlue),
          // const ShapeWidget(color: colorOrange, shape: Shapes.TriangleRed),
          // const ShapeWidget(color: colorOrange, shape: Shapes.TriangleGreen),
          // const ShapeWidget(color: colorBlue,   shape: Shapes.Trapezoid),
          // const ShapeWidget(color: colorBlue,   shape: Shapes.RectWithTriangle),
          // const ShapeWidget(color: colorBlue,   shape: Shapes.RectWithoutTriangle),
        ],
      ),
    );
  }
}
