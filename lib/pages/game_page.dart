//each shape is build of positions array. blocks are states. and there is
// a widget getShapes() which iterates all points of the businessLogic.shapes . Points are
// rendered.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/blocks/levels.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/puzzleToSolveWidget.dart';
import 'package:tangram/widgets/shapes/allShapesWidget.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeightPixel = screenHeight(context);
    var screenWidthPixel = screenWidth(context);
    var mediaQueryData = MediaQuery.of(context);
    var screenSize = mediaQueryData.size;
    log.d('screen size   width:${screenSize.width}   height: ${screenSize.height}\n');
    log.d('screen size option 2.  width:$screenWidthPixel  height: $screenHeightPixel');
    var points = BlocProvider.of<LevelsBloc>(context).state.pointSystem!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.teal,
          height: screenHeightPixel,
          width: screenWidthPixel,
          child: Stack(
            children: <Widget>[
              //  const WidgetGridLines(),
              Container(
                color: Colors.white38,
                child: PuzzleToSolveWidget(
                  offset: Offset(0,0),
                  path: pointSystemsToPath(points, pointSizeFromContext(context)),
                ),
              ),
            //  const AllShapesWidget(),
              /*
              Positioned(
                bottom: 50,
                right: 20,
                child: Container(
                  child: FloatingActionButton(
                      onPressed: () {
                        var myState = BlocProvider.of<MovementsBloc>(context).state;
                        BlocProvider.of<SolverBloc>(context).add(ShapeStartedRotation(
                            offset: myState.positionsMap[myState.focusShape]!,
                            points: myState.baseShapeMap[myState.focusShape]!.points));
                        BlocProvider.of<MovementsBloc>(context).add(RotatedRight());
                      },
                      child: Icon(Icons.autorenew_rounded)),
                ),
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}
