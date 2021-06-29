import 'package:flutter/cupertino.dart';

class ShapePainter extends CustomPainter {
  final Color color;
  final Offset offset; //origin
  final Path path;

  const ShapePainter(
      {
        required this.color,
        required this.path,
        required this.offset,});

  @override
  bool hitTest(Offset position) {
    var position1 = position+offset;
    var hitTest = path.contains(position1);
    return hitTest;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
    //canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  String toString() {
    return 'ShapePainter{path: $path}';
  }
}