import 'package:tangram/businessLogic/shapes/trapezoid.dart';
import 'package:tangram/widgets/shapes/shapeWidget.dart';

class TrapezoidWidget extends ShapeWidget {
  final Trapezoid trapezoid;

  const TrapezoidWidget({
    required this.trapezoid,
    required settings,
    required color,
  }) : super(
          baseShape: trapezoid,
          settings: settings,
          color: color,
        );
}
