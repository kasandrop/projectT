import 'package:flutter/material.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/shapes/shapes.dart';

import 'PuzzleToSolve.dart';
import 'drawShapes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenWidget(),
    );
  }
}

//each shape is build of positions array. blocks are states. and there is
// a widget getShapes() which iterates all points of the shapes . Points are
// rendered.

class ScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int screenWidth = MediaQuery.of(context).size.width.toInt();
    int screenHeight = MediaQuery.of(context).size.height.toInt();
    Settings settings = Settings(
      pixelHeight: screenHeight,
      pixelWidth: screenWidth,
      boardWidth: 8,
    );
    print(settings);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: WidgetGridLines(
            settings: settings,
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: DrawShapes(
                shapes: [
                  Trapezoid(x: 4, y: 7),
                  RectangleWithTriangle(x: 1, y: 4),
                  Triangle(x: 0, y: 1),
                  Triangle(x: 3, y: 1),
                  Triangle(x: 6, y: 1),
                  RectangleWithoutTriangle(x: 1, y: 6),
                ],
                color: Colors.green,
                settings: settings,
              ),
            )),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: DrawShapes(
                shapes: [
                  PuzzleToSolve(
                    x: 0,
                    y: 8,
                    settings: settings,
                  )
                ],
                settings: settings,
                color: Colors.red,
              ),
            )),
        Positioned(
          bottom: 50,
          right: 20,
          child: Container(
            child: FloatingActionButton(
              onPressed: () => print('marcin'),
              child: Icon(Icons.autorenew_rounded),
            ),
          ),
        ),
      ],
    );
  }
}

class WidgetGridLines extends StatelessWidget {
  final Settings settings;

  const WidgetGridLines({
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinesGrid(
        color: Theme.of(context).primaryColor,
        boardWidth: settings.boardWidth,
        pixelHeight: settings.pixelHeight,
        pointSize: settings.pointSize,
        startPoint: Offset(0, 0),
        pixelWidth: settings.pixelWidth,
        boardHeight: settings.boardHeight,
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

  LinesGrid({
    required this.color,
    required this.startPoint,
    required this.pointSize,
    required this.boardWidth,
    required this.boardHeight,
    required this.pixelHeight,
    required this.pixelWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 0.0;
    Path path = Path();
    for (int i = 0; i <= boardWidth; i++) {
      var offset1 = startPoint + Offset((i * pointSize).toDouble(), 0);
      var offset2 = offset1 + Offset(0, pixelHeight.toDouble());
      path.moveTo(offset1.dx, offset1.dy);
      path.lineTo(offset1.dx, offset2.dy);
      path.moveTo(offset1.dx, offset1.dy);
    }
    for (int i = 0; i <= boardHeight; i++) {
      var offset1 = startPoint + Offset(0, (i * pointSize).toDouble());
      var offset2 = offset1 + Offset(pixelWidth.toDouble(), 0);
      path.moveTo(offset1.dx, offset1.dy);
      path.lineTo(offset2.dx, offset2.dy);
      path.moveTo(offset1.dx, offset1.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
/*
class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    var angle = pi * 2 / 4;
    Offset center = Offset(size.width / 2, size.height / 2);
    //starting point (200,0)

    var radius = 300.0;
    Offset startPoint = Offset(radius, 0);
    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);
    List<Offset> points = List<Offset>.generate(
        1,
        (index) => Offset(radius * cos(angle * (index + 1)) + center.dx,
            radius * sin(angle * (index + 1)) + center.dy));

    //
    points.forEach((element) => path.lineTo(element.dx, element.dy));
    points.forEach((element) => print({element.dx, element.dy}));
    path.lineTo(center.dx, center.dy);
    //path.lineTo(points.first.dx, points.first.dy);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
*/
