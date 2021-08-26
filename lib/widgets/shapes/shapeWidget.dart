import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triangram/blocs/data/data.dart';
import 'package:triangram/blocs/solver/solver.dart';
import 'package:triangram/data/models/visibility_shapes.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:triangram/util/top_level_functions.dart';

import '../shape_from_path_widget.dart';

class ShapeWidget extends StatelessWidget {
  final Shapes shape;
  final bool isFocus;

  const ShapeWidget({
    Key? key,
    required this.shape,
    required this.isFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.d('build');

    // var areAllShapesVisible = (context).select<VisibilityShape, bool>(
    //         (VisibilityShape vs) => vs.areAllVisible);
    var isVisible =
        !(context).select<VisibilityShape, bool>((VisibilityShape vs) => vs.isHidden[shape.index]);
    var pointSize = pointSizeFromContext(context);
    return BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {},
        buildWhen: (previous, current) =>
            current.currentFocus == null ? false : current.currentFocus == shape,
        builder: (context, state) {
          log.d('builder of consumer');
          var color = state.getShape(shape).color;
          var colorFrom = state.getShape(shape).colorFrom;
          var colorTo = state.getShape(shape).colorTo;
          var positionOfBoundingRect = state.getShape(shape).positionOfBoundingRectangle;
          var dy = positionOfBoundingRect.dy;
          var dx = positionOfBoundingRect.dx;
          var path = state.getPathForUi(shape: shape, pointSize: pointSizeFromContext(context));
          var size = getSizeFromShape(shape) * pointSizeFromContext(context);
          var angle = math.pi / 180 * state.getShape(shape).positionInList * 45;

          if (state.isSolved()) {
            log.d('state.isSolved');
            BlocProvider.of<SolverBloc>(context).add(UpdateMapEvent(map: state.pathOfAllShapes));
          }

          // log.d('are All shapes visible: $areAllShapesVisible');
          // var isSolved =
          //     state.isSolved(areAllShapesVisible: areAllShapesVisible);
          // log.d('>>>>>>>>>>>>>>>Solved:$isSolved<<<<<<<<<<<<<<<<<<<<');
          return Positioned(
            top: dy * pointSizeFromContext(context),
            left: dx * pointSizeFromContext(context),
            child: Visibility(
                visible: isVisible,
                child: Draggable(
                  key: ObjectKey(shape),
                  childWhenDragging: Container(),
                  feedback: Transform.rotate(
                    key: ObjectKey(shape),
                    angle: angle,
                    child: ShapeFromPathWidget(
                      key: ObjectKey(shape),
                      //elevation: 5,
                      shadowColor: Theme.of(context).colorScheme.onPrimary,
                      // colorFrom: colorFrom,
                      // colorTo: colorTo,
                      path: path,
                      size: size,
                      color: color,
                      state: DraggableState.dragged,
                      //   shape:shape,
                    ),
                  ),
                  onDragEnd: (DraggableDetails e) {
                    var res = e.offset / pointSize;
                    //log.d('test what is the e.offset= ${e.offset} and e.offset/pointssize= $res}');
                    BlocProvider.of<DataBloc>(context).add(PositionEvent(
                        //focusShape:shape,
                        positionOfBoundingRectangle: (e.offset) / pointSize));
                  },
                  onDragStarted: () {
                    // log.d('focusEvent shape:$shape');
                    BlocProvider.of<DataBloc>(context).add(FocusEvent(focusShape: shape));
                  },
                  child: Transform.rotate(
                    key: ObjectKey(shape),
                    angle: angle,
                    child: ShapeFromPathWidget(
                      //elevation: 5,
                      shadowColor: Theme.of(context).colorScheme.onPrimary,
                      key: ObjectKey(shape),
                      size: size,
                      path: path,
                      color: color,
                      state: (isFocus == true) ? DraggableState.focused : DraggableState.enabled,
                      // colorFrom: colorFrom,
                      // colorTo: colorTo,

                      // shape:shape),
                    ),
                  ),
                )),
          );
        });
  }
}
