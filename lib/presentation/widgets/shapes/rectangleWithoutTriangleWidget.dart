import 'package:tangram/business/shapes/rectangleWithoutTriangle.dart';
import 'package:tangram/presentation/widgets/shapes/shapeWidget.dart';

class RectangleWithoutTriangleWidget extends ShapeWidget {
  final RectangleWithoutTriangle rectangleWithoutTriangle;

  const RectangleWithoutTriangleWidget({
    required this.rectangleWithoutTriangle,
    required settings,
    required color,
  }) : super(
          baseShape: rectangleWithoutTriangle,
          settings: settings,
          color: color,
        );
}
