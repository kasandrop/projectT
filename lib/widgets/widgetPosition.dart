import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetPosition {
  double x = 0;
  double y = 0;
  Size size = Size(0, 0);

  WidgetPosition({required this.x, required this.y, required this.size});

  WidgetPosition.fromContext(BuildContext context) {
    var object = context.findRenderObject() as RenderBox;
    x = object.semanticBounds.topLeft.dx;
    y = object.semanticBounds.topLeft.dy;
    size = object.semanticBounds.size;
  }

  // Obtain the button RenderObject

  @override
  String toString() {
    return 'WidgetPosition{x: $x, y: $y, size: $size}';
  }
}
