import 'package:tangram/businessLogic/shapes/triangle.dart';
import 'package:tangram/widgets/shapes/shapeWidget.dart';

class TriangleWidget extends ShapeWidget {
  final Triangle triangle;

  const TriangleWidget({
    required this.triangle,
    required settings,
    required color,
  }) : super(
          baseShape: triangle,
          settings: settings,
          color: color,
        );
}
