//each shape is build of positions array. blocks are states. and there is
// a widget getShapes() which iterates all points of the businessLogic.shapes . Points are
// rendered.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/blocs/Levels/levels.dart';
import 'package:tangram/blocs/data/data.dart';
import 'package:tangram/blocs/solver/solver.dart';
import 'package:tangram/config/injection_container.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/visibility_shapes.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/bottom_panel.dart';
import 'package:tangram/widgets/puzzle_to_solve_widget.dart';
import 'package:tangram/widgets/shapes/allShapesWidget.dart';

class GamePage extends StatelessWidget {
  GamePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeightPixel = screenHeight(context);
    var screenWidthPixel = screenWidth(context);
    var puzzle = BlocProvider.of<LevelsBloc>(context).state.puzzle;
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
          create: (BuildContext buildContext) => sl<DataBloc>(),
        ),
        BlocProvider<SolverBloc>(
          create: (BuildContext context) => SolverBloc(
            map: sl<GameShapes>().getPathMap(1),
            puzzlePath: puzzle.getPath(pointSize: 1),
          ),
        ),
      ],
      child: ChangeNotifierProvider<VisibilityShape>(
          create: (_) => sl<VisibilityShape>(),
          child: Scaffold(
            body: SafeArea(
              child: Container(
                color: kDarkGrey,
                height: screenHeightPixel,
                width: screenWidthPixel,
                child: Stack(
                  children: <Widget>[
                    //  const WidgetGridLines(),
                    Container(
                      child: PuzzleToSolveWidget(
                        offset: Offset(0, 0),
                        puzzle: puzzle,
                        pointSize: pointSizeFromContext(context),
                      ),
                    ),

                    const AllShapesWidget(key: ValueKey('AllShapesWidget')),

                    Positioned(bottom: 80, left: 4, child: BottomPanel()),
                    // Positioned(
                    //   bottom: 80,
                    //   right: 20,
                    //   child: Builder(builder: (BuildContext context) {
                    //     return ;
                    //   }),
                    // ),
                    // Positioned(
                    //   bottom: 20,
                    //   right: 20,
                    //   child: Builder(builder: (BuildContext context) {
                    //     return ;
                    //   }),
                    // ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
