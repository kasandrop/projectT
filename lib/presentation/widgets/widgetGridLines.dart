import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangram/util/settings.dart';

//Todo: add keys and const to all widgets
class WidgetGridLines extends StatelessWidget {
  const WidgetGridLines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<Settings>(context);

    return CustomPaint(
      painter: LinesGrid(
        color: Theme.of(context).primaryColor,
        boardWidth: settings.boardWidth,
        boardHeight: settings.boardHeight,
        pixelHeight: settings.pixelHeight,
        pixelWidth: settings.pixelWidth,
        pointSize: settings.pointSize,
        //TODO:to align check later
        startPoint: Offset.zero,
      ),
      child: Container(),
    );
  }
}

class LinesGrid extends CustomPainter {
  final Color color;
  final Offset startPoint;
  final int pointSize;
  final int boardWidth;
  final int boardHeight;
  final int pixelHeight;
  final int pixelWidth;

  const LinesGrid(
      {required this.color,
      required this.startPoint,
      required this.pointSize,
      required this.boardWidth,
      required this.boardHeight,
      required this.pixelHeight,
      required this.pixelWidth});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(startPoint.dx, startPoint.dy);
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 0.0;
    Path path = Path();
    for (int i = 0; i <= boardWidth; i++) {
      var offset1 = Offset((i * pointSize).toDouble(), 0);
      var offset2 = Offset(
          (i * pointSize).toDouble(), (pixelHeight - 2 * startPoint.dy).toDouble());
      path.moveTo(offset1.dx, offset1.dy);
      path.lineTo(offset2.dx, offset2.dy);
      // path.moveTo(offset1.dx, offset1.dy);
    }
    for (int i = 0; i <= boardHeight; i++) {
      var offset1 = Offset(0, (i * pointSize).toDouble());
      var offset2 =
          Offset(pixelWidth.toDouble() - 2 * startPoint.dx, (i * pointSize).toDouble());

      path.moveTo(offset1.dx, offset1.dy);
      path.lineTo(offset2.dx, offset2.dy);
      //path.moveTo(offset1.dx, offset1.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
