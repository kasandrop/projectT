import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/business/useCases/get_initial_points.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/widgets/puzzleToSolveWidget.dart';
import 'package:tangram/presentation/widgets/screenWidget.dart';
import 'package:tangram/presentation/widgets/shapes/allShapesWidget.dart';
import 'package:tangram/presentation/widgets/widgetGridLines.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/settings.dart';
import 'package:flutter/rendering.dart';
import 'business/PuzzleToSolve.dart';
import 'business/shapes/rectWithTriangle.dart';
import 'business/shapes/rectWithoutTriangle.dart';
import 'business/shapes/trapezoid.dart';
import 'business/shapes/triangle.dart';
import 'business/useCases/GetInitialPositionsOfTheShapes.dart';
import 'business/useCases/MovingMechanismUseCase.dart';

void main() {
  // debugPaintSizeEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MovingMechanismUseCase movingMechanismUseCase = MovingMechanismUseCase();
  final GetPointsUseCase getPointsUseCase = GetPointsUseCase(
    rectangleWithoutTriangle: RectWithoutTriangle(),
    rectangleWithTriangle: RectWithTriangle(),
    trapezoid: Trapezoid(),
    triangleBlue: Triangle(),
    triangleGreen: Triangle(),
    triangleRed: Triangle(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugPaintPointersEnabled = true,
      debugShowCheckedModeBanner: false,
      title: 'Flutter ',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BlocProvider(
        create: (context) => MovementsBloc(
            getInitialPositionsOfTheShapesUseCase:
                const GetInitialPositionsOfTheShapesUseCase(),
            //global pure function in a file,
            getPointsUseCase: getPointsUseCase,
            movingMechanismUseCase: movingMechanismUseCase),
        child: const ScreenWidget(),
      ),
    );
  }
}
