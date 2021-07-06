import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tangram/blocs/Levels/levels.dart';
import 'package:tangram/blocs/data/data_bloc.dart';
import 'package:tangram/blocs/solver/solver.dart';
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
    () =>const  Triangle(
        color: kColorGreen,
        shape: Shapes.TriangleGreen,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 1)),
    instanceName: 'Shapes.TriangleGreen',
  );
  sl.registerFactory<ShapeProduct>(
    () => const  RectWithoutTriangle(
        color: kColorOrange,
        shape: Shapes.RectWithoutTriangle,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.RectWithoutTriangle',
  );
  sl.registerFactory<ShapeProduct>(
    () => const RectWithTriangle(
        color: kColorOrange,
        shape: Shapes.RectWithTriangle,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(3, 3)),
    instanceName: 'Shapes.RectWithTriangle',
  );
  sl.registerFactory<ShapeProduct>(
    () =>const  Trapezoid(
        color: kColorOrange,
        shape: Shapes.Trapezoid,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 1)),
    instanceName: 'Shapes.Trapezoid',
  );
  sl.registerFactory<ShapeOrder>(() => ShapeOrder(
        order: <Shapes>[ ],
      ));

  sl.registerFactory<GameShapes>(() => GameShapes(
        shapes: <Shapes, ShapeProduct>{
          Shapes.TriangleRed: sl(instanceName: 'Shapes.TriangleRed'),
          Shapes.TriangleBlue: sl(instanceName: 'Shapes.TriangleBlue'),
          Shapes.TriangleGreen: sl(instanceName: 'Shapes.TriangleGreen'),
          Shapes.Trapezoid: sl(instanceName: 'Shapes.Trapezoid'),
          Shapes.RectWithTriangle: sl(instanceName: 'Shapes.RectWithTriangle'),
          Shapes.RectWithoutTriangle:
              sl(instanceName: 'Shapes.RectWithoutTriangle'),
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

  sl.registerFactory<DataBloc>(
    () => DataBloc(
      gameShapes: sl(),
      shapeOrder: sl(),
    ),
  );



  //ui
  sl.registerSingleton<VisibilityShape>(
    VisibilityShape(isHidden: [
      true,
      true,
      true,
      true,
      true,
      true,
    ]),
  );
}
