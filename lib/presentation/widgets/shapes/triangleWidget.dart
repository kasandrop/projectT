import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/shape_enum.dart';

class TriangleWidget extends StatefulWidget {
  final List<PointSystem> points;
  final int x;
  final int y;
  final Settings settings;
  final Color color;
  final Shapes shape;

  const TriangleWidget({
    Key? key,
    required this.points,
    required this.settings,
    required this.color,
    required this.x,
    required this.y,
    required this.shape,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TriangleWidgetState();
}

class TriangleWidgetState extends State<TriangleWidget> {
  Offset position = Offset(0, 0);
  Offset delta = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    List<Positioned> visiblePoints = [];

    widget.points.forEach((PointSystem point) {
      // print('visible points x:${point.dx} y:${point.dy}');
      visiblePoints.add(Positioned(
        top: point.dy * widget.settings.pointSize.toDouble(),
        left: point.dx * widget.settings.pointSize.toDouble(),
        child: DrawPoint(
          settings: widget.settings,
          pointSystem: point,
          color: widget.color,
        ),
      ));
    });
    //print('visible points size:${visiblePoints.length}');
    return Positioned(
      top: position.dy * widget.settings.pointSize.toDouble(),
      left: position.dx * widget.settings.pointSize.toDouble(),
      child: Draggable(
        onDragStarted: () => BlocProvider.of<MovementsBloc>(context)
            .add(ShapeFocused(shape: widget.shape)),
        // onDraggableCanceled: (velocity, offset) {
        //   log.d('onDraggableCanceled  offset:${offset}');
        //   setState(() {
        //     position = Offset((offset.dx / widget.settings.pointSize).roundToDouble(),
        //         (offset.dy / widget.settings.pointSize).roundToDouble());
        //   });
        // },

        onDragUpdate: (details) {
          delta = details.delta + delta;
          // log.d('onDragUpdate  details Delta:${delta}');
          if (delta.dx > widget.settings.pointSize) {
            setState(() {
              position = Offset(1, 0) + position;
              delta = Offset(0, delta.dy);
            });
          }
          if (delta.dy > widget.settings.pointSize) {
            setState(() {
              position = Offset(0, 1) + position;
              delta = Offset(delta.dx, 0);
            });
          }
          if (delta.dx < widget.settings.pointSize * (-1)) {
            setState(() {
              position = Offset(-1, 0) + position;
              delta = Offset(0, delta.dy);
              ;
            });
          }
          if (delta.dy < widget.settings.pointSize * (-1)) {
            setState(() {
              position = Offset(0, -1) + position;
              delta = Offset(delta.dx, 0);
            });
          }
        },
        child: GestureDetector(
          onTap: () => BlocProvider.of<MovementsBloc>(context)
              .add(ShapeFocused(shape: widget.shape)),
          child: Container(
              height: widget.settings.pointSize * 2,
              width: widget.settings.pointSize * 2,
              child: Stack(children: visiblePoints)),
        ),
        feedback: Container(
            height: widget.settings.pointSize * 2,
            width: widget.settings.pointSize * 2,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/triangle.png"),
              ),
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    position = Offset(widget.x.toDouble(), widget.y.toDouble());
  }
}
