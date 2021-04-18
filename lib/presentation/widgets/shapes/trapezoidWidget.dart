import 'package:tangram/business/shapes/trapezoid.dart';
import 'package:tangram/presentation/widgets/shapes/shapeWidget.dart';

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
