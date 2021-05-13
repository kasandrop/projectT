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
    var settings = Provider.of<Settings>(context);
    //log.d(' pixel height:${settings.pixelHeight.toDouble()}');
    return Scaffold(
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
                      onPressed: () => {
                            log.d('..tap'),
                            BlocProvider.of<MovementsBloc>(context)
                                .add(RotatedRight()),
                          },
                      child: Icon(Icons.autorenew_rounded)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
