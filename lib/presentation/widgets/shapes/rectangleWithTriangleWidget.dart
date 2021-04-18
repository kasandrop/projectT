import 'package:tangram/business/shapes/rectangleWithTriangle.dart';
import 'package:tangram/presentation/widgets/shapes/shapeWidget.dart';

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
