import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/bloc/movements/movements.dart';
import 'package:tangram/bloc/solver/solver.dart';
import 'package:tangram/data/models/point_system.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/settings.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/draw_point_widget.dart';

class ShapeWidget extends StatelessWidget {
  final Color color;
  final Shapes shape;
  final Offset offset;
  final Path path;

  const ShapeWidget({
    Key? key,
    required this.color,
    required this.shape,
    required this.offset,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pointSize=pointSizeFromContext(context);
    var dx=pointSize * getBoardSize(shape: shape);
    var dy =pointSize * getBoardSize(shape: shape);
    var size=Size(dx,dy);
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
              path:path,
              offset:offset,
            //  size:size,
              color: color,
            ),
            feedback: ShapeFromPointsWidget(
                key: ObjectKey('feedback'),
                path:path,
               // size:size,
                offset:offset,
                color: color),
            onDragEnd: (e) {
              BlocProvider.of<MovementsBloc>(context).add(DraggingFinished());

              var pointsCovered =
                  BlocProvider
                      .of<SolverBloc>(context)
                      .state
                      .pointsCovered;
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
               // size:size,
                offset: offset,
                path:path,
                color: color),
            //  childWhenDragging: ShapeFromPointsWidget(pointSize: pointSize, shape: shape, pointsSystem: pointsSystem, color: color),
          ),
        );
      },
    );
  }
}

class ShapeFromPointsWidget extends StatelessWidget {
 // final Size size;
  final Color color;
  final Path path;
  final Offset offset;


  const ShapeFromPointsWidget({
    Key? key,
   // required this.size,
     required this.color,
    required this.path,
    required this.offset,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    var pointSize=pointSizeFromContext(context);

    return Container(
     //   height:size.height,
      //  width: size.width,
        child: CustomPaint(
       //   size: size,
          painter: ShapePainter(
            path: path,
            color: color,
            offset: offset,
          ),
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
