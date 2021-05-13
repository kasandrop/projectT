import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/solver/solver_bloc.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/point_system.dart';
import 'package:tangram/util/settings.dart';
import 'package:tangram/util/shape_enum.dart';

class ShapeWidget extends StatelessWidget {
  final Color color;
  final Shapes shape;

  const ShapeWidget({
    Key? key,
    required this.color,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log.d('$shape');

    return BlocBuilder<MovementsBloc, MovementsState>(
        builder: (context, state) {
      final pointSize = Provider.of<Settings>(context).pointSize.toDouble();
      final dx = state.positionsMap[shape]!.dx;
      final dy = state.positionsMap[shape]!.dy;
      final pointsSystem = state.baseShapeMap[shape]!.points;
      return PositionedWrapper(
        dx: dx * pointSize,
        dy: dy * pointSize,
        pointSize: pointSize,
        shape: shape,
        color: color,
        pointsSystem: pointsSystem,
      );
    });
  }
}

class PositionedWrapper extends StatelessWidget {
  final double pointSize;
  final Shapes shape;
  final List<PointSystem> pointsSystem;
  final Color color;
  final double dx;
  final double dy;

  const PositionedWrapper({
    Key? key,
    required this.pointSize,
    required this.shape,
    required this.pointsSystem,
    required this.color,
    required this.dx,
    required this.dy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: dy,
      left: dx,
      child: DraggableWrapper(
          shape: shape,
          pointSize: pointSize,
          pointsSystem: pointsSystem,
          color: color,
          dx: dx,
          dy: dy),
    );
  }
}

class DraggableWrapper extends StatelessWidget {
  const DraggableWrapper({
    Key? key,
    required this.shape,
    required this.pointSize,
    required this.pointsSystem,
    required this.color,
    required this.dx,
    required this.dy,
  }) : super(key: key);

  final Shapes shape;
  final double pointSize;
  final List<PointSystem> pointsSystem;
  final Color color;
  final double dx;
  final double dy;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      key: ObjectKey('draggable'),
      //  rootOverlay: true,
      childWhenDragging: ShapeFromPointsWidget(
        key: ObjectKey('childWhenDragging'),
        pointSize: pointSize,
        shape: shape,
        pointsSystem: pointsSystem,
        color: color,
      ),
      feedback: ShapeFromPointsWidget(
          key: ObjectKey('feedback'),
          pointSize: pointSize,
          shape: shape,
          pointsSystem: pointsSystem,
          color: color),

      onDragEnd: (e) {
        //  log.d('onDragEnd');
        BlocProvider.of<MovementsBloc>(context).add(DraggedFinished());
        BlocProvider.of<SolverBloc>(context).add(ShapeFinishedDragDataEvent(
            offset: Offset(dx, dy), points: pointsSystem));
      },
      onDragStarted: () {
        //log.d('onDragStarted');
        BlocProvider.of<MovementsBloc>(context)
            .add(ShapeFocused(focusShape: shape));
        BlocProvider.of<MovementsBloc>(context).add(DragStarted(
          pointSizeInt: pointSize.toInt(),
        ));
        BlocProvider.of<SolverBloc>(context).add(ShapeStartedDragDataEvent(
            offset: Offset(dx, dy), points: pointsSystem));
      },
      onDragUpdate: (details) {
        //log.d('onDragUpdate');
        final delta = Offset(details.delta.dx, details.delta.dy);
        BlocProvider.of<MovementsBloc>(context).add(
          ShapeDragged(
            delta: delta,
          ),
        );
      },
      child: ShapeFromPointsWidget(
          key: ObjectKey('child'),
          pointSize: pointSize,
          shape: shape,
          pointsSystem: pointsSystem,
          color: color),
      //  childWhenDragging: ShapeFromPointsWidget(pointSize: pointSize, shape: shape, pointsSystem: pointsSystem, color: color),
    );
  }
}

class ShapeFromPointsWidget extends StatelessWidget {
  const ShapeFromPointsWidget({
    Key? key,
    required this.pointSize,
    required this.shape,
    required this.pointsSystem,
    required this.color,
  }) : super(key: key);

  final double pointSize;
  final Shapes shape;
  final List<PointSystem> pointsSystem;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pointSize * getBoardSize(shape: shape),
      width: pointSize * getBoardSize(shape: shape),
      child: Stack(
        children: pointsSystem
            .map((PointSystem point) => Positioned(
                  top: point.dy * pointSize,
                  left: point.dx * pointSize,
                  child: DrawPoint(
                    pointSize: pointSize,
                    pointSystem: point,
                    color: color,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class MyFeedback extends StatelessWidget {
  final double pointSize;
  final Shapes shape;
  final ImageProvider<Object> imageProvider;

  const MyFeedback(
      {Key? key,
      required this.pointSize,
      required this.shape,
      required this.imageProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pointSize * getBoardSize(shape: shape),
      width: pointSize * getBoardSize(shape: shape),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: imageProvider,
        ),
      ),
    );
  }
}

class ModifyContainer extends StatelessWidget {
  final Shapes shape;
  final Widget Function(ImageProvider<Object>) assetBuilder;

  const ModifyContainer({
    Key? key,
    required this.assetBuilder,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> assetImage;

    if (Shapes.RectWithTriangle == shape) {
      assetImage = const AssetImage(shapesRectWithTriangle);
    } else if (Shapes.RectWithoutTriangle == shape) {
      assetImage = const AssetImage(shapesRectWithoutTriangle);
    } else if (Shapes.TriangleGreen == shape) {
      assetImage = const AssetImage(shapesTriangleGreen);
    } else if (Shapes.TriangleRed == shape) {
      assetImage = const AssetImage(shapesTriangleRed);
    } else if (Shapes.TriangleBlue == shape) {
      assetImage = const AssetImage(shapesTriangleBlue);
    } else {
      assetImage = const AssetImage(shapesTrapezoid);
    }

    return assetBuilder(assetImage);
  }
}
