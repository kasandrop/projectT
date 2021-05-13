import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/business/solver_helper.dart';
import 'package:tangram/business/useCases/get_initial_rotation_points_usecase.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/solver/solver_bloc.dart';
import 'package:tangram/presentation/widgets/screenWidget.dart';
import 'package:tangram/util/settings.dart';

import 'business/PuzzleToSolve.dart';
import 'business/shapes/rectWithTriangle.dart';
import 'business/shapes/rectWithoutTriangle.dart';
import 'business/shapes/trapezoid.dart';
import 'business/shapes/triangle.dart';
import 'business/useCases/MovingMechanismUseCase.dart';
import 'business/useCases/get_initial_positions__usecase.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Home(),
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

  final MovingMechanismUseCase movingMechanismUseCase =
  MovingMechanismUseCase();
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
    final points = Provider
        .of<PuzzleToSolve>(context)
        .points;
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovementsBloc>(
          create: (BuildContext context) =>
              MovementsBloc(
                  getInitialPositionsOfTheShapesUseCase:
                  const GetInitialPositionsUseCase(),
                  getInitialRotationPointsUseCase: getPointsUseCase,
                  movingMechanismUseCase: movingMechanismUseCase),
        ),
        BlocProvider<SolverBloc>(
          create: (BuildContext context) =>
              SolverBloc(
                puzzleToSolvePoints: points,
                solverHelper: SolverHelper(),
              ),
        ),
      ],
      child: const ScreenWidget(),
    );
  }
}
