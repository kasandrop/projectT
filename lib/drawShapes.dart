import 'package:flutter/cupertino.dart';
import 'package:tangram/coordinateSystem.dart';
import 'package:tangram/settings.dart';

class DrawShapes extends StatelessWidget {
  final Settings settings;
  final PointSystem pointSystem;

  DrawShapes({
    required this.settings,
    required this.pointSystem,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(settings.pixelWidth.toDouble(), settings.pixelWidth.toDouble()),
      painter: FillerPainter(
        offset: Offset(
            settings.pixelWidth.toDouble() / 2, settings.pixelWidth.toDouble() / 2),
        pointSystem: pointSystem,
      ),
    );
  }
}

/*
offset the middle point in the PointSystem
 */
class FillerPainter extends CustomPainter {
  final Offset offset;
  final int dxMiddle;
  final int dyMiddle;
  final PointSystem pointSystem;

  FillerPainter({
    required this.offset,
    required this.pointSystem,
  })   : dxMiddle = offset.dx.toInt(),
        dyMiddle = offset.dy.toInt();

  @override
  void paint(Canvas canvas, Size size) {
    if (pointSystem.east == true &&
        pointSystem.north == true &&
        pointSystem.south == true &&
        pointSystem.west == true) {}
    Path path = new Path();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
