import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/data/models/solver_helper.dart';
import 'package:tangram/pages/game_page.dart';
import 'package:tangram/pages/home_page.dart';
import 'package:tangram/useCases/MovingMechanismUseCase.dart';
import 'package:tangram/useCases/get_initial_positions__usecase.dart';
import 'package:tangram/useCases/get_initial_rotation_points_usecase.dart';
import 'package:tangram/util/settings.dart';

import 'bloc/movements/movements.dart';
import 'bloc/solver/solver.dart';
import 'data/models/PuzzleToSolve.dart';
import 'data/models/shapes/rectWithTriangle.dart';
import 'data/models/shapes/rectWithoutTriangle.dart';
import 'data/models/shapes/trapezoid.dart';
import 'data/models/shapes/triangle.dart';

void main() {
  // debugPaintSizeEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Triangram',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenSize = mediaQueryData.size;
    var settings = Settings(
      pixelHeight: screenSize.height.toInt(),
      pixelWidth: screenSize.width.toInt(),
    );
    //log.d(settings);
    var puzzleSolve = PuzzleToSolve(settings: settings, x: 3, y: 4);

    return MultiProvider(
      providers: [
        Provider<Settings>.value(value: settings),
        Provider<PuzzleToSolve>.value(value: puzzleSolve),
      ],
      child: AppSettings(),
    );
  }
}

class AppSettings extends StatelessWidget {
  AppSettings({Key? key}) : super(key: key);

  final MovingMechanismUseCase movingMechanismUseCase = MovingMechanismUseCase();
  final GetInitialRotationPointsUseCase getPointsUseCase =
      GetInitialRotationPointsUseCase(
    rectangleWithoutTriangle: RectWithoutTriangle(),
    rectangleWithTriangle: RectWithTriangle(),
    trapezoid: Trapezoid(),
    triangleBlue: Triangle(),
    triangleGreen: Triangle(),
    triangleRed: Triangle(),
  );

  @override
  Widget build(BuildContext context) {
    final points = Provider.of<PuzzleToSolve>(context).points;
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovementsBloc>(
          create: (BuildContext context) => MovementsBloc(
              getInitialPositionsOfTheShapesUseCase: const GetInitialPositionsUseCase(),
              getInitialRotationPointsUseCase: getPointsUseCase,
              movingMechanismUseCase: movingMechanismUseCase),
        ),
        BlocProvider<SolverBloc>(
          create: (BuildContext context) => SolverBloc(
            solverHelper: SolverHelper(puzzleToSolvePoints: points),
          ),
        ),
      ],
      child: const GamePage(),
    );
  }
}
