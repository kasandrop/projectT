import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/blocs/data/data.dart';
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
    log.d('build');
    // var solverBloc = context.watch<SolverBloc>();
    // log.d('ha ha czy rozwiazane: ${solverBloc.state.isPuzzleCovered}');
    // var areAllShapesVisible = (context).select<VisibilityShape, bool>(
    //         (VisibilityShape vs) => vs.areAllVisible);
    var isVisible =
        !(context).select<VisibilityShape, bool>((VisibilityShape vs) => vs.isHidden[shape.index]);
    var pointSize = pointSizeFromContext(context);
    return BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {},
        buildWhen: (previous, current) {
          if (current.currentFocus == null) return false;
          var result = current.currentFocus == shape;
          // log.d(
          //     'current.currentfocus: ${current.currentFocus}== shape:$shape result of ==:$result');
          return result;
        },
        builder: (context, state) {
          log.d('builder of consumer');
          var pos = state.gameShapes.shapes[Shapes.TriangleBlue]?.positionOfBoundingRectangle;
          var color = state.getShape(shape).color;
          var positionOfBoundingRect = state.getShape(shape).positionOfBoundingRectangle;
          var dy = positionOfBoundingRect.dy;
          var dx = positionOfBoundingRect.dx;
          var path = state.getPathForUi(shape: shape, pointSize: pointSizeFromContext(context));
          var offset = Offset(0, 0);
          var size = getSizeFromShape(shape) * pointSizeFromContext(context);
          var angle = -math.pi / 180 * state.getShape(shape).positionInList * 45;

          if (state.isSolved()) {
            BlocProvider.of<SolverBloc>(context).add(UpdateMapEvent(map: state.pathOfAllShapes));
            log.d('Can calll function to solve now');
          }else{
            BlocProvider.of<SolverBloc>(context).add(NoFreshUpdatesEvent());
          }

          // log.d('are All shapes visible: $areAllShapesVisible');
          // var isSolved =
          //     state.isSolved(areAllShapesVisible: areAllShapesVisible);
          // log.d('>>>>>>>>>>>>>>>Solved:$isSolved<<<<<<<<<<<<<<<<<<<<');
          return  Positioned(
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
                      path: path,
                      size: size,
                      offset: offset,
                      color: color,
                      //   shape:shape,
                    ),
                  ),
                  onDragEnd: (DraggableDetails e) {
                    BlocProvider.of<DataBloc>(context).add(PositionEvent(
                        //focusShape:shape,
                        positionOfBoundingRectangle: e.offset / pointSize));
                  },
                  onDragStarted: () {
                    // log.d('focusEvent shape:$shape');
                    BlocProvider.of<DataBloc>(context).add(FocusEvent(focusShape: shape));
                  },
                  child: Transform.rotate(
                    key: ObjectKey(shape),
                    angle: angle,
                    child: ShapeFromPathWidget(
                      key: ObjectKey(shape),
                      size: size,
                      offset: offset,
                      path: path,
                      color: color,

                      // shape:shape),
                    ),
                  ),
                )),
          );
        });
  }
}


