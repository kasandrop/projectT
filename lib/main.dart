import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/blocs/Levels/levels.dart';
import 'package:tangram/pages/home_page.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/logger.dart';

import 'blocs/triangram_bloc_observer.dart';
import 'config/injection_container.dart';
import 'config/routes/route_generator.dart';

void main() async{
  // debugPaintSizeEnabled = true;
  //debugPaintPointersEnabled = true;
  //WidgetsFlutterBinding.ensureInitialized();
Bloc.observer=TriangramBlocObserver();
 await init();
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
              color: Colors.purple),
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
//
// class Home extends StatelessWidget {
//   Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var mediaQueryData = MediaQuery.of(context);
//     var screenSize = mediaQueryData.size;
//     var settings = Settings(
//       pixelHeight: screenSize.height.toInt(),
//       pixelWidth: screenSize.width.toInt(),
//     );
//     //log.d(settings);
//     var puzzleSolve = PuzzleToSolve(settings: settings, x: 3, y: 4);
//
//     return MultiProvider(
//       providers: [
//         Provider<Settings>.value(value: settings),
//         Provider<PuzzleToSolve>.value(value: puzzleSolve),
//       ],
//       child: AppSettings(),
//     );
//   }
// }

// class AppSettings extends StatelessWidget {
//   AppSettings({Key? key}) : super(key: key);
//
//   final MovingMechanismUseCase movingMechanismUseCase = MovingMechanismUseCase();
//   final GetInitialRotationPointsUseCase getPointsUseCase =
//       GetInitialRotationPointsUseCase(
//     rectangleWithoutTriangle: RectWithoutTriangle(),
//     rectangleWithTriangle: RectWithTriangle(),
//     trapezoid: Trapezoid(),
//     triangleBlue: Triangle(),
//     triangleGreen: Triangle(),
//     triangleRed: Triangle(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final points = Provider.of<PuzzleToSolve>(context).points;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<MovementsBloc>(
//           create: (BuildContext context) => MovementsBloc(
//               getInitialPositionsOfTheShapesUseCase: const GetInitialPositionsUseCase(),
//               getInitialRotationPointsUseCase: getPointsUseCase,
//               movingMechanismUseCase: movingMechanismUseCase),
//         ),
//         // BlocProvider<SolverBloc>(
//         //   create: (BuildContext context) => SolverBloc(
//         //   puzzleToSolve:,
//         //   ),
//         // ),
//       ],
//       child: Container(), // const GamePage(),
//     );
//   }
// }
