import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/blocs/solver/solver.dart';
import 'package:tangram/data/models/visibility_shapes.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:tangram/util/top_level_functions.dart';

import '../shape_from_path_widget.dart';

class ShapeWidget extends StatelessWidget {
  final Shapes shape;

  const ShapeWidget({
    Key? key,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pointSize = pointSizeFromContext(context);
    return BlocConsumer<SolverBloc, SolverState>(
        listener: (context, state) {},
        builder: (context, state) {
          var color = state.getShape(shape).color;
          var positionOfBoundingRect =
              state.getShape(shape).positionOfBoundingRectangle;
          var dy = positionOfBoundingRect.dy;
          var dx = positionOfBoundingRect.dx;
          var path = state.getPathForUi(
              shape: shape, pointSize: pointSizeFromContext(context));
          var offset = Offset(0, 0);
          var size = getSizeFromShape(shape) * pointSizeFromContext(context);
          var angle =
              -math.pi / 180 * state.getShape(shape).positionInList * 45;
          var isSolved = state.isSolved();
          var isVisible=(context).select<VisibilityShape,bool>((VisibilityShape vs) => vs.isSelected[shape.index]);
          log.d('Solved:$isSolved');
          return Positioned(
            top: dy * pointSizeFromContext(context),
            left: dx * pointSizeFromContext(context),
            child:Visibility(visible:isVisible,child: Draggable(

              //  feedbackOffset: Offset.fromDirection(angle),
              // dragAnchorStrategy:pointerDragAnchorStrategy ,
              key: ValueKey(shape),
              childWhenDragging:Container(),
              feedback: Transform.rotate(
                key: ValueKey(shape),
                angle: angle,
                child: ShapeFromPathWidget(
                  key: ValueKey(shape),
                  path: path,
                  size: size,
                  offset: offset,
                  color: color,

                  //   shape:shape,
                ),
              ),
              onDragEnd: (DraggableDetails e) {
                BlocProvider.of<SolverBloc>(context).add(PositionEvent(
                    positionOfBoundingRectangle: e.offset / pointSize));
              },

              onDragStarted: () {
                BlocProvider.of<SolverBloc>(context).add(FocusEvent(focusShape: shape));
              },

              child: Transform.rotate(
                key:  ValueKey( shape),
                angle: angle,
                child: ShapeFromPathWidget(
                    key: ValueKey( shape),
                    size: size,
                    offset: offset,
                    path: path,
                    color: color,

                    // shape:shape),
                    ),
              ),
            )),
          );
        }

        //  childWhenDragging: ShapeFromPointsWidget(pointSize: pointSize, shape: shape, pointsSystem: pointsSystem, color: color),
        );
  }
}
