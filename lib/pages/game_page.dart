//each shape is build of positions array. blocks are states. and there is
// a widget getShapes() which iterates all points of the businessLogic.shapes . Points are
// rendered.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triangram/blocs/Levels/levels.dart';
import 'package:triangram/blocs/data/data.dart';
import 'package:triangram/blocs/solver/solver.dart';
import 'package:triangram/config/injection_container.dart';
import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/visibility_shapes.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/top_level_functions.dart';
import 'package:triangram/widgets/bottom_panel.dart';
import 'package:triangram/widgets/puzzle_to_solve_widget.dart';
import 'package:triangram/widgets/shapes/allShapesWidget.dart';

class GamePage extends StatelessWidget {
  GamePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeightPixel = screenHeight(context);
    var screenWidthPixel = screenWidth(context);
    var puzzle = BlocProvider.of<LevelsBloc>(context).state.puzzle;
    var pointSize = pointSizeFromContext(context);
    var puzzlePathForUi = puzzle.getPathForUi(pointSize: pointSize);
    var puzzleSize = Size(puzzlePathForUi.getBounds().width, puzzlePathForUi.getBounds().height);
    var offsetAlignment =
        Offset(horizontalAlignment(context: context, widthToAlign: puzzleSize.width), 0);
    var normalizeOffset = Offset((offsetAlignment.dx / pointSize).round().toDouble(),
        (offsetAlignment.dy / pointSize).round().toDouble());
    puzzle.puzzleOffset = normalizeOffset;
    //puzzle.puzzleOffset=Offset(0,0);
    // log.d('alignment: ${puzzle.puzzleOffset}');
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
          create: (BuildContext buildContext) => sl<DataBloc>()..puzzle = puzzle,
        ),
        BlocProvider<SolverBloc>(
          create: (BuildContext context) => SolverBloc(
              pathsForShape: PathsForShapes(map: sl<GameShapes>().getMyPathMap(pointSize: 1)),
              puzzle: puzzle),
        ),
      ],
      child: ChangeNotifierProvider<VisibilityShape>(
          create: (_) => sl<VisibilityShape>(),
          child: Scaffold(
            body: SafeArea(
                child: Material(
              type: MaterialType.canvas,
              elevation: 5,
              shadowColor: Theme.of(context).colorScheme.onSurface,
              child: Container(
                height: screenHeightPixel,
                width: screenWidthPixel,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: normalizeOffset.dx * pointSize,
                      child: PuzzleToSolveWidget(
                        puzzlePath: puzzlePathForUi,
                      ),
                    ),

                    const AllShapesWidget(key: ValueKey('AllShapesWidget')),

                    //  const WidgetGridLines(),

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
            )),
          )),
    );
  }
}
