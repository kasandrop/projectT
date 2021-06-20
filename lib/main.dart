import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/blocks/levels.dart';
import 'package:tangram/data/models/solver_helper.dart';
import 'package:tangram/data/useCases/MovingMechanismUseCase.dart';
import 'package:tangram/data/useCases/get_initial_positions__usecase.dart';
import 'package:tangram/data/useCases/get_initial_rotation_points_usecase.dart';
import 'package:tangram/pages/home_page.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/settings.dart';

import 'bloc/movements/movements.dart';
import 'bloc/solver/solver.dart';
import 'config/injection_container.dart';
import 'config/injection_container.dart' as di;
import 'config/routes/route_generator.dart';
import 'data/models/PuzzleToSolve.dart';
import 'data/models/shapes/rectWithTriangle.dart';
import 'data/models/shapes/rectWithoutTriangle.dart';
import 'data/models/shapes/trapezoid.dart';
import 'data/models/shapes/triangle.dart';
import 'data/useCases/MovingMechanismUseCase.dart';
import 'data/useCases/get_initial_positions__usecase.dart';
import 'data/useCases/get_initial_rotation_points_usecase.dart';

void main() async{
  // debugPaintSizeEnabled = true;
  //debugPaintPointersEnabled = true;
  //WidgetsFlutterBinding.ensureInitialized();

 await di.init();
  runApp(SplashApp(
    key: UniqueKey(),
    onInitializationComplete: () => runApp(Application()),
  ));
}

class SplashApp extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashApp({Key? key, required this.onInitializationComplete}) : super(key: key);

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  @override
  Widget build(BuildContext context) {
    log.d('build');
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(
              color: Colors.purple, semanticsLabel: 'Linear progress indicator'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initialise();
  }

  Future<void> _initialise() async {
    await sl.allReady();
    widget.onInitializationComplete();
  }
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log.d('build');
    return BlocProvider(
      create: (BuildContext buildContext) => sl<LevelsBloc>(),
      child: MaterialApp(
        initialRoute: Routes.home,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Triangram',
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
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
      child: Container(), // const GamePage(),
    );
  }
}
