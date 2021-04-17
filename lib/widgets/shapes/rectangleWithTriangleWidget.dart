import 'package:tangram/businessLogic/shapes/rectangleWithTriangle.dart';
import 'package:tangram/widgets/shapes/shapeWidget.dart';

class RectangleWithTriangleWidget extends ShapeWidget {
  final RectangleWithTriangle rectangleWithTriangle;

  const RectangleWithTriangleWidget({
    required this.rectangleWithTriangle,
    required settings,
    required color,
  }) : super(
          baseShape: rectangleWithTriangle,
          settings: settings,
          color: color,
        );
}
