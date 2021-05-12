import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/business/useCases/get_initial_rotation_points_usecase.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/widgets/screenWidget.dart';

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
                const GetInitialPositionsUseCase(),
            getInitialRotationPointsUseCase: getPointsUseCase,
            movingMechanismUseCase: movingMechanismUseCase),
        child: const ScreenWidget(),
      ),
    );
  }
}
