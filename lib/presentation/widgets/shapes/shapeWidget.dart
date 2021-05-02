import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/logger.dart';
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

    return BlocBuilder<MovementsBloc, MovementsState>(builder: (context, state) {
      double pointSize = Provider.of<Settings>(context).pointSize.toDouble();
      return Positioned(
        //  key: ValueKey(151),
        top: state.positionsMap[shape]!.dy * pointSize,
        left: state.positionsMap[shape]!.dx * pointSize,

        child: Draggable(
          rootOverlay: true,
          onDragEnd: (details) {
            // Offset delta = Offset(details.delta.dx, details.delta.dy);
            //   delta: delta,
            //    ),
            log.d('drag ended');
          },
          onDragStarted: () {
            log.d('onDragStarted');
            BlocProvider.of<MovementsBloc>(context).add(ShapeFocused(focusShape: shape));
            BlocProvider.of<MovementsBloc>(context).add(
              DragStarted(
                pointSizeInt: pointSize.toInt(),
              ),
            );
          },
          onDragUpdate: (details) {
            Offset delta = Offset(details.delta.dx, details.delta.dy);
            log.d('so it was onDragUpdate');
            BlocProvider.of<MovementsBloc>(context).add(
              ShapeDragged(
                delta: delta,
              ),
            );
          },
          // onDraggableCanceled: (velocity, offset) {
          //   //log.d('onDraggableCanceled  offset:${offset}');
          //
          //   BlocProvider.of<MovementsBloc>(context).add(
          //     DraggableCancelled(
          //       offset: offset,
          //     ),
          //   );
          // },
          // child: GestureDetector(
          //   onTap: () => BlocProvider.of<MovementsBloc>(context)
          //       .add(ShapeFocused(focusShape: shape)),
          //behavior: HitTestBehavior.opaque,

          childWhenDragging: Container(
              height: pointSize * getBoardSize(shape: shape),
              width: pointSize * getBoardSize(shape: shape),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(getAssetPath(shape: shape)),
                ),
              )),
          child: Container(
            //color: Colors.yellow,
            height: pointSize * getBoardSize(shape: shape),
            //global pure function in a file
            width: pointSize * getBoardSize(shape: shape),
            child: Stack(
              children: state.pointsMap[shape]!
                  .map(
                    (PointSystem point) => Positioned(
                      top: point.dy * pointSize,
                      left: point.dx * pointSize,
                      child: DrawPoint(
                        pointSize: pointSize,
                        pointSystem: point,
                        color: color,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          //),
          feedback: Container(
              height: pointSize * getBoardSize(shape: shape),
              width: pointSize * getBoardSize(shape: shape),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(getAssetPath(shape: shape)),
                ),
              )),
        ),
      );
    });
    // }
    //);
  }
}
