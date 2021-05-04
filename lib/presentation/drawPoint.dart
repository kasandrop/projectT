import 'package:flutter/material.dart';
import 'package:tangram/util/coordinateSystem.dart';

class DrawPoint extends StatelessWidget {
  final PointSystem pointSystem;
  final Color color;
  final double pointSize;
  const DrawPoint({
    required this.pointSystem,
    required this.color,
    required this.pointSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(pointSize, pointSize),
      painter: FillerPainter(
        path: Path(),
        pointSize: pointSize,
        pointSystem: pointSystem,
        color: color,
        startPoint: Offset.zero,
      ),
    );
  }
}

/*
 point size ->in pixel size of the point
 */
//TODO: class Settings  properties better  int or double check that
class FillerPainter extends CustomPainter {
  final double pointSize;
  final double dxMiddle;
  final double dyMiddle;
  final Color color;
  final Offset startPoint; //origin

  final PointSystem pointSystem;

  //TODO: created path to inject to constructor to make it const
  final Path path;

  const FillerPainter(
      {required this.pointSize,
      required this.pointSystem,
      required this.color,
      required this.startPoint,
      required this.path})
      : dxMiddle = pointSize / 2,
        dyMiddle = pointSize / 2;

  @override
  bool hitTest(Offset position) {
    Offset position1 = position + startPoint;
    bool hitTest = path.contains(position1);
    return hitTest;
  }

  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    if (pointSystem.east == true &&
        pointSystem.north == true &&
        pointSystem.south == true &&
        pointSystem.west == true) {
      path.moveTo(0, 0);
      path.lineTo(pointSize, 0);
      path.lineTo(pointSize, pointSize);
      path.lineTo(0, pointSize);
      path.close();
    } else {
      if (pointSystem.east == true) {
        Path tempPath = Path();
        tempPath.moveTo(dxMiddle, dyMiddle);
        tempPath.lineTo(pointSize, 0);
        tempPath.lineTo(pointSize, pointSize);
        tempPath.close();
        path.addPath(tempPath, Offset.zero);
      }
      if (pointSystem.south == true) {
        Path tempPath = Path();
        tempPath.moveTo(dxMiddle, dyMiddle);
        tempPath.lineTo(pointSize, pointSize);
        tempPath.lineTo(0, pointSize);
        tempPath.close();
        path.addPath(tempPath, Offset.zero);
      }
      if (pointSystem.west == true) {
        Path tempPath = Path();
        tempPath.moveTo(dxMiddle, dyMiddle);
        tempPath.lineTo(0, 0);
        tempPath.lineTo(0, pointSize);

        tempPath.close();
        path.addPath(tempPath, Offset.zero);
      }
      if (pointSystem.north == true) {
        Path tempPath = Path();
        tempPath.moveTo(dxMiddle, dyMiddle);
        tempPath.lineTo(0, 0);
        tempPath.lineTo(pointSize, 0);
        tempPath.close();

        path.addPath(tempPath, Offset.zero);
      }
    }

    canvas.drawPath(path, paint);
    //canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  String toString() {
    return 'FillerPainter{path: $path}';
  }
}
