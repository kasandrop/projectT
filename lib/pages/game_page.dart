//each shape is build of positions array. blocks are states. and there is
// a widget getShapes() which iterates all points of the businessLogic.shapes . Points are
// rendered.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/bloc/movements/movements.dart';
import 'package:tangram/bloc/solver/solver.dart';
import 'package:tangram/data/models/PuzzleToSolve.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/settings.dart';
import 'package:tangram/widgets/puzzleToSolveWidget.dart';
import 'package:tangram/widgets/shapes/allShapesWidget.dart';
import 'package:tangram/widgets/widgetGridLines.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settings = Provider.of<Settings>(context);
    //log.d(' pixel height:${settings.pixelHeight.toDouble()}');
    return BlocListener<SolverBloc, SolverState>(
      listener: (context, state) {
        log.d('Points covered: ${state.pointsCovered}\n solved? ${state.solved}');
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: settings.pixelHeight.toDouble(),
            width: settings.pixelWidth.toDouble(),
            child: Stack(
              children: <Widget>[
                const WidgetGridLines(),
                PuzzleToSolveWidget(
                  puzzleToSolve: Provider.of<PuzzleToSolve>(context),
                ),
                const AllShapesWidget(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
