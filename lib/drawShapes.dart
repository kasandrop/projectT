import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tangram/coordinateSystem.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/shapes/baseShape.dart';

class DrawShapes extends StatelessWidget {
  final List<BaseShape> shapes;

  final Settings settings;
  final Color color;

  DrawShapes({
    required this.shapes,
    required this.settings,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Positioned> visiblePoints = [];
    shapes.forEach((BaseShape shape) {
      shape.points.forEach((PointSystem point) {
        print('visible points x:${point.dx} y:${point.dy}');
        visiblePoints.add(Positioned(
          top: point.dy * settings.pointSize.toDouble(),
          left: point.dx * settings.pointSize.toDouble(),
          child: DrawPoint(
            settings: settings,
            pointSystem: point,
            color: color,
          ),
        ));
      });
    });
    print('visible points size:${visiblePoints.length}');
    return Stack(children: visiblePoints);
  }
}

class DrawPoint extends StatelessWidget {
  final Settings settings;
  final PointSystem pointSystem;
  final Color color;

  const DrawPoint({
    required this.settings,
    required this.pointSystem,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(settings.pointSize.toDouble(), settings.pointSize.toDouble()),
      painter: FillerPainter(
        pointSize: settings.pointSize.toDouble(),
        pointSystem: pointSystem,
        color: color,
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

  final PointSystem pointSystem;

  const FillerPainter({
    required this.pointSize,
    required this.pointSystem,
    required this.color,
  })   : dxMiddle = pointSize / 2,
        //(pointSize/2).toInt()
        dyMiddle = pointSize / 2;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    var paint = Paint();
    paint.color = color;

    // paint.strokeWidth = 3;
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
