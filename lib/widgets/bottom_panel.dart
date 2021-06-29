import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/blocs/solver/solver.dart';
import 'package:tangram/data/models/visibility_shapes.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/shape_from_path_widget.dart';
import'dart:math' as math;

class BottomPanel extends StatelessWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // var listOfSelected = context.select((VisibilityShape vS) => vS.isSelected);
    var pointSizeScaled = pointSizeFromContext(context, 17);
    return BlocBuilder<SolverBloc, SolverState>(builder: (context, state) {
      return Consumer<VisibilityShape>(builder: (context, value, child) {
        var widgets = Shapes.values
            .map(
              (e) =>
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(),
                child: ShapeFromPathWidget(
                    size: getSizeFromShape(e) * pointSizeScaled * _scale(e: e),
                    color: (value.isSelected[e.index] == true)
                        ? state
                        .getShape(e)
                        .color
                        .withOpacity(0.2)
                        : state
                        .getShape(e)
                        .color,
                    path: state.getPathForUi(
                        shape: e, pointSize: pointSizeScaled * _scale(e: e)),
                    offset: Offset(0, 0)),
              ),
        ).toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ToggleButtons(
                    onPressed: (index) {
                      //log.d('list $listOfSelected');
                      Provider.of<VisibilityShape>(context, listen: false).toggleElement = index;
                    if  (value.isSelected[index]==true){
                      BlocProvider.of<SolverBloc>(context).add(FocusEvent(focusShape:Shapes.values.elementAt(index)));
                      log.d('pokaz duzy trojkat');
                    }else{
                      BlocProvider.of<SolverBloc>(context).add(HideFocusEvent(focusShape:Shapes.values.elementAt(index)));
                      log.d('schowaj duzy trojkat');
                    }

                    },
                    isSelected: value.isSelected,
                    children: [
                      widgets[0],
                      widgets[1],
                      widgets[2],
                      widgets[3],
                      widgets[4],
                      widgets[5]
                    ]
                ),
                FloatingActionButton(heroTag:UniqueKey(),
                  onPressed: () {
                    BlocProvider.of<SolverBloc>(context)
                        .add(LeftRotationEvent());
                  },
                  child: Icon(Icons.autorenew_sharp),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                FloatingActionButton(heroTag:UniqueKey(),
                  onPressed: () {
                    BlocProvider.of<SolverBloc>(context)
                        .add(RightRotationEvent());
                  },
                  child:   Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(Icons.autorenew_sharp),
                  ),
                ),
              ],
            ),
          ],
        );
      });
    });
  }

  double _scale({required Shapes e}) {
    if (e == Shapes.RectWithTriangle ||
        e == Shapes.RectWithoutTriangle ||
        e == Shapes.Trapezoid) {
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
