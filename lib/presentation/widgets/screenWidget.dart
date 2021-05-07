//each shape is build of positions array. blocks are states. and there is
// a widget getShapes() which iterates all points of the businessLogic.shapes . Points are
// rendered.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/business/PuzzleToSolve.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/widgets/puzzleToSolveWidget.dart';
import 'package:tangram/presentation/widgets/shapes/allShapesWidget.dart';
import 'package:tangram/presentation/widgets/widgetGridLines.dart';
import 'package:tangram/util/logger.dart';
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
              value: settings,
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Stack(
                  children: <Widget>[
                    const WidgetGridLines(),
                    PuzzleToSolveWidget(
                      puzzleToSolve: PuzzleToSolve(settings: settings, x: 3, y: 4),
                    ),
                    const AllShapesWidget(),
                    Positioned(
                      bottom: 50,
                      right: 20,
                      child: Container(
                        child: FloatingActionButton(
                            child: Icon(Icons.autorenew_rounded),
                            onPressed: () => {
                                  log.d('..tap'),
                                  BlocProvider.of<MovementsBloc>(context)
                                      .add(RotatedRight()),
                                }),
                      ),
                    ),
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
