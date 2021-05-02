import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/widgets/shapes/rectWithoutTriangleWidget.dart';
import 'package:tangram/presentation/widgets/shapes/shapesWidget.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/logger.dart';
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
          ShapeWidget(
            // key: GlobalKey(),
            color: Colors.blue,
            shape: Shapes.TriangleBlue,
          ),
          ShapeWidget(
            //  key: GlobalKey(),
            color: Colors.orange,
            shape: Shapes.TriangleRed,
          ),
          ShapeWidget(
            color: Colors.green,
            shape: Shapes.TriangleGreen,
          ),
          ShapeWidget(
            //    key: GlobalKey(),
            color: Colors.blue,
            shape: Shapes.Trapezoid,
          ),
          ShapeWidget(
            //  key: GlobalKey(),
            color: Colors.blue,
            shape: Shapes.RectWithTriangle,
          ),
          ShapeWidget(
            // key: GlobalKey(),
            color: Colors.blue,
            shape: Shapes.RectWithoutTriangle,
          ),
        ],
      ),
    );
  }
}
