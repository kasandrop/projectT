import 'package:tangram/business/shapes/triangle.dart';
import 'package:tangram/presentation/widgets/shapes/shapeWidget.dart';

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
