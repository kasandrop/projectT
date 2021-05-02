//each shape is build of positions array. blocks are states. and there is
// a widget getShapes() which iterates all points of the businessLogic.shapes . Points are
// rendered.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangram/business/PuzzleToSolve.dart';
import 'package:tangram/presentation/widgets/puzzleToSolveWidget.dart';
import 'package:tangram/presentation/widgets/shapes/allShapesWidget.dart';
import 'package:tangram/presentation/widgets/widgetGridLines.dart';
import 'package:tangram/util/settings.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            Settings settings = Settings(
              pixelHeight: constraints.maxHeight.toInt(),
              pixelWidth: constraints.maxWidth.toInt(),
            );
            return Provider<Settings>.value(
              //key: ValueKey(33),
              value: settings,
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const WidgetGridLines(key: ValueKey(41)),
                    PuzzleToSolveWidget(
                      key: ValueKey(38),
                      puzzleToSolve: PuzzleToSolve(settings: settings, x: 3, y: 4),
                    ),
                    const AllShapesWidget(key: ValueKey(42)),
                    // Positioned(
                    //   key: ValueKey(51),
                    //   bottom: 50,
                    //   right: 20,
                    //   child: Container(
                    //     child: FloatingActionButton(
                    //       onPressed: () => {log.d('fucking tap')},
                    //       //     BlocProvider.of<MovementsBloc>(context).add(RotatedRight()),
                    //       child: Icon(Icons.autorenew_rounded),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
