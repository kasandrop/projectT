import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triangram/blocs/data/data.dart';
import 'package:triangram/data/models/visibility_shapes.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:triangram/util/top_level_functions.dart';
import 'package:triangram/widgets/shape_from_path_widget.dart';
import 'dart:math' as math;

class BottomPanel extends StatelessWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var areAllShapesHidden = context.select((VisibilityShape vS) => vS.areAllHidden);
    var pointSizeScaled = pointSizeFromContext(context, 17);
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      return Consumer<VisibilityShape>(builder: (context, value, child) {
        var widgets = Shapes.values
            .map(
              (e) => Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(),
                child: ShapeFromPathWidget(
                  state: DraggableState.none,
                  size: getSizeFromShape(e) * pointSizeScaled * _scale(e: e),
                  color: (value.isHidden[e.index] == false)
                      ? state.getShape(e).color.withOpacity(0.2)
                      : state.getShape(e).color,
                  // colorFrom: (value.isHidden[e.index] == false)
                  //     ? state.getShape(e).colorFrom.withOpacity(0.2)
                  //     : state.getShape(e).colorFrom,
                  // colorTo: (value.isHidden[e.index] == false)
                  //     ? state.getShape(e).colorTo.withOpacity(0.2)
                  //     : state.getShape(e).colorTo,
                  // elevation: 4,
                  shadowColor: Theme.of(context).colorScheme.onSurface,
                  path: state.getPathForUi(shape: e, pointSize: pointSizeScaled * _scale(e: e)),
                ),
              ),
            )
            .toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ToggleButtons(
                    onPressed: (index) {
                      var temp = value.isHidden[index];
                      //log.d('list $listOfSelected');
                      Provider.of<VisibilityShape>(context, listen: false).toggleElement = index;
                      if (temp == true) {
                        BlocProvider.of<DataBloc>(context)
                            .add(ShowShapeEvent(showShape: Shapes.values.elementAt(index)));
                      } else {
                        BlocProvider.of<DataBloc>(context)
                            .add(HideShapeEvent(hideShape: Shapes.values.elementAt(index)));
                      }
                    },
                    isSelected: value.isHidden,
                    children: [
                      widgets[0],
                      widgets[1],
                      widgets[2],
                      widgets[3],
                      widgets[4],
                      widgets[5]
                    ]),
                FloatingActionButton(
                  heroTag: UniqueKey(),
                  onPressed: () {
                    if (areAllShapesHidden) return;
                    BlocProvider.of<DataBloc>(context).add(LeftRotationEvent());
                  },
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(Icons.autorenew_sharp),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: UniqueKey(),
                  onPressed: () {
                    if (areAllShapesHidden) return;
                    BlocProvider.of<DataBloc>(context).add(RightRotationEvent());
                  },
                  child: Icon(Icons.autorenew_sharp),
                ),
              ],
            ),
          ],
        );
      });
    });
  }

  double _scale({required Shapes e}) {
    if (e == Shapes.RectWithTriangle || e == Shapes.RectWithoutTriangle || e == Shapes.Trapezoid) {
      return 0.5;
    }
    return 1;
  }
}
//
// ShapeForThePanel(
// key: ValueKey(Shapes.RectWithoutTriangle),
// color: cRectWithoutTriangle,
// shape: Shapes.RectWithoutTriangle,
// path: state.getPathForUi(
// shape: Shapes.RectWithoutTriangle,
// pointSize: pointSizeFromContext(context),
// ),
// pointSizePanel: settings.pointSizePanel * 0.5,
// ),
/*







 */
