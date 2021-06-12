import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/bloc/movements/movements.dart';
import 'package:tangram/bloc/solver/solver.dart';
import 'package:tangram/data/models/point_system.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/settings.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:tangram/widgets/draw_point_widget.dart';

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
    return BlocConsumer<MovementsBloc, MovementsState>(
      listener: (context, state) {
        if (state.rotation && state.focusShape == shape) {
          BlocProvider.of<SolverBloc>(context).add(ShapeFinishedRotation(
              offset: state.positionsMap[shape]!,
              points: state.baseShapeMap[shape]!.points));
        }

        if (state.dragFinished && state.focusShape == shape) {
          BlocProvider.of<SolverBloc>(context).add(ShapeFinishedDragDataEvent(
              offset: state.positionsMap[shape]!,
              points: state.baseShapeMap[shape]!.points));
        }
      },
      builder: (context, state) {
        final pointSize = Provider.of<Settings>(context).pointSize.toDouble();
        final dx = state.positionsMap[shape]!.dx;
        final dy = state.positionsMap[shape]!.dy;
        final pointsSystem = state.baseShapeMap[shape]!.points;
        return Positioned(
          top: dy * pointSize,
          left: dx * pointSize,
          child: Draggable(
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
              BlocProvider.of<MovementsBloc>(context).add(DraggingFinished());

              var pointsCovered =
                  BlocProvider.of<SolverBloc>(context).state.pointsCovered;
              log.d('pointsCovered:$pointsCovered');
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
                ShapeDragging(
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
          ),
        );
      },
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
                  child: DrawPointWidget(
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

// class MyFeedback extends StatelessWidget {
//   final double pointSize;
//   final Shapes shape;
//   final ImageProvider<Object> imageProvider;
//
//   const MyFeedback(
//       {Key? key,
//       required this.pointSize,
//       required this.shape,
//       required this.imageProvider})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: pointSize * getBoardSize(shape: shape),
//       width: pointSize * getBoardSize(shape: shape),
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           fit: BoxFit.fill,
//           image: imageProvider,
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class ModifyContainer extends StatelessWidget {
//   final Shapes shape;
//   final Widget Function(ImageProvider<Object>) assetBuilder;
//
//   const ModifyContainer({
//     Key? key,
//     required this.assetBuilder,
//     required this.shape,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final ImageProvider<Object> assetImage;
//
//     if (Shapes.RectWithTriangle == shape) {
//       assetImage = const AssetImage(shapesRectWithTriangle);
//     } else if (Shapes.RectWithoutTriangle == shape) {
//       assetImage = const AssetImage(shapesRectWithoutTriangle);
//     } else if (Shapes.TriangleGreen == shape) {
//       assetImage = const AssetImage(shapesTriangleGreen);
//     } else if (Shapes.TriangleRed == shape) {
//       assetImage = const AssetImage(shapesTriangleRed);
//     } else if (Shapes.TriangleBlue == shape) {
//       assetImage = const AssetImage(shapesTriangleBlue);
//     } else {
//       assetImage = const AssetImage(shapesTrapezoid);
//     }
//
//     return assetBuilder(assetImage);
//   }
// }
