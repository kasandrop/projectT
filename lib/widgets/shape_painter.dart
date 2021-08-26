import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:triangram/widgets/shape_from_path_widget.dart';

class ShapePainter extends CustomPainter {
  final Color color;
  final Path path;

  //final double elevation;
  final Color shadowColor;
  final DraggableState state;

  const ShapePainter({
    required this.color,
    required this.path,
    //required this.elevation,
    required this.shadowColor,
    required this.state,
  });

  @override
  bool hitTest(Offset position) {
    var position1 = position;
    var hitTest = path.contains(position1);
    return hitTest;
  }

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    var paint = Paint();
    var paintBorder;
    var elevation;
    paintBorder = Paint();
    paintBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.23;
    // canvas.clipPath(path);

    switch (state) {
      case DraggableState.focused:
        paint.color = Color.alphaBlend(Colors.white.withOpacity(0.12), color);
        paintBorder.color = Colors.white;
        elevation = 5.0;
        break;
      case DraggableState.dragged:
        paint.color = Color.alphaBlend(Colors.white.withOpacity(0.08), color);
        elevation = 5.0 + 8.0;
        paintBorder.color = Color.alphaBlend(Colors.black87.withOpacity(0.42), color);
        break;
      case DraggableState.enabled:
        elevation = 5.0;
        paint.color = color;
        paintBorder.color = Color.alphaBlend(Colors.black87.withOpacity(0.42), color);
        break;
      default:
        paint.color = color;
        elevation = 0.0;
        paintBorder.color = Color.alphaBlend(Colors.black87.withOpacity(0.42), color);
    }
    canvas.drawShadow(path, shadowColor, elevation, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paintBorder);

    //shape_border.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  String toString() {
    return 'ShapePainter{path: $path}';
  }
}
