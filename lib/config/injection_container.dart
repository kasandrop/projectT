import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tangram/blocs/Levels/levels.dart';
import 'package:tangram/blocs/solver/solver_bloc.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:tangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:tangram/data/models/shapeProduct/shape_data.dart';
import 'package:tangram/data/models/shapeProduct/triangle.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/data/models/visibility_shapes.dart';
import 'package:tangram/data/repositories/level_repository.dart';
import 'package:tangram/data/useCases/get_levels_use_case.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/shape_enum.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //services

  //repositories

  sl.registerSingleton<LevelsRepository>(
    LevelsRepositoryImpl(),
  );

  //use cases
  sl.registerSingleton<GetLevelsUseCase>(
    GetLevelsUseCase(
      levelsRepository: sl(),
    ),
  );

  var levels = await sl<GetLevelsUseCase>().call();

  sl.registerFactory<LevelsState>(() => LevelsState(
        levels: levels,
        currentLevelNumber: -1,
      ));

  //game shapes
  sl.registerFactory<ShapeProduct>(
    () => Triangle(
        color: kColorOrange,
        shape: Shapes.TriangleRed,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.TriangleRed',
  );
  sl.registerFactory<ShapeProduct>(
    () => Triangle(
        color: kColorBlue,
        shape: Shapes.TriangleBlue,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 0)),
    instanceName: 'Shapes.TriangleBlue',
  );
  sl.registerFactory<ShapeProduct>(
    () => Triangle(
        color: kColorGreen,
        shape: Shapes.TriangleGreen,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 1)),
    instanceName: 'Shapes.TriangleGreen',
  );
  sl.registerFactory<ShapeProduct>(
    () => RectWithoutTriangle(
        color: kColorOrange,
        shape: Shapes.RectWithoutTriangle,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.RectWithoutTriangle',
  );
  sl.registerFactory<ShapeProduct>(
    () => RectWithTriangle(
        color: kColorOrange,
        shape: Shapes.RectWithTriangle,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(3, 3)),
    instanceName: 'Shapes.RectWithTriangle',
  );
  sl.registerFactory<ShapeProduct>(
    () => Trapezoid(
        color: kColorOrange,
        shape: Shapes.Trapezoid,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 1)),
    instanceName: 'Shapes.Trapezoid',
  );
  sl.registerFactory<ShapeOrder>(() => ShapeOrder(
        order: <Shapes>[
          Shapes.Trapezoid,
          Shapes.TriangleBlue,
          Shapes.TriangleRed,
          Shapes.TriangleGreen,
          Shapes.RectWithoutTriangle,
          Shapes.RectWithTriangle,
        ],
      ));

  sl.registerFactory<GameShapes>(() => GameShapes(
        shapeOrder: sl(),
        shapes: <Shapes, ShapeProduct>{
          Shapes.Trapezoid: sl(instanceName: 'Shapes.Trapezoid'),
          Shapes.TriangleBlue: sl(instanceName: 'Shapes.TriangleBlue'),
          Shapes.TriangleRed: sl(instanceName: 'Shapes.TriangleRed'),
          Shapes.TriangleGreen: sl(instanceName: 'Shapes.TriangleGreen'),
          Shapes.RectWithoutTriangle:
              sl(instanceName: 'Shapes.RectWithoutTriangle'),
          Shapes.RectWithTriangle: sl(instanceName: 'Shapes.RectWithTriangle'),
        },
      ));

  //=========blocks
  sl.registerFactory<LevelsBloc>(
    () => LevelsBloc(
      initialState: sl(),
      getLevelsUseCase: sl(),
      lastLevelCompleted: 0,
    ),
  );

  sl.registerFactory<SolverBloc>(
    () => SolverBloc(
      gameShapes: sl(),
      shapeOrder: sl(),
    ),
  );

  //ui
  sl.registerSingleton<VisibilityShape>(
    VisibilityShape(isSelected: [
      false,
      false,
      false,
      false,
      false,
      false,
    ]),
  );
}
