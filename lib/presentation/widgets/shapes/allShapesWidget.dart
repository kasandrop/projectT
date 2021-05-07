import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangram/presentation/widgets/shapes/shapeWidget.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/settings.dart';
import 'package:tangram/util/shape_enum.dart';

class AllShapesWidget extends StatelessWidget {
  const AllShapesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Provider.of<Settings>(context).pixelWidth.toDouble(),
      height: Provider.of<Settings>(context).pixelHeight.toDouble(),
      child: Stack(
        children: <Widget>[
          const ShapeWidget(color: colorBlue, shape: Shapes.TriangleBlue),
          const ShapeWidget(color: colorOrange, shape: Shapes.TriangleRed),
          const ShapeWidget(color: colorOrange, shape: Shapes.TriangleGreen),
          const ShapeWidget(color: colorBlue, shape: Shapes.Trapezoid),
          const ShapeWidget(color: colorBlue, shape: Shapes.RectWithTriangle),
          const ShapeWidget(
              color: colorBlue, shape: Shapes.RectWithoutTriangle),
        ],
      ),
    );
  }
}
