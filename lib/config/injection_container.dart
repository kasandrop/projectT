import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:triangram/blocs/Levels/levels.dart';
import 'package:triangram/blocs/data/data_bloc.dart';
import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:triangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:triangram/data/models/shapeProduct/shape_data.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/data/models/shape_order.dart';
import 'package:triangram/data/models/visibility_shapes.dart';
import 'package:triangram/data/repositories/level_repository.dart';
import 'package:triangram/data/useCases/get_levels_use_case.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/shape_enum.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  log.d('inside init');
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
    () => const Triangle(
      color: kColorOrange,
      colorFrom: kColorOrangeLight,
      colorTo: kColorOrangeDark,
      origin: Triangle.shapeOrigin,
      size: Triangle.shapeSize,
      isAnchored: false,
      shape: Shapes.TriangleRed,
      positionInList: 0,
      positionOfBoundingRectangle: Offset(0, 0),
    ),
    instanceName: 'Shapes.TriangleRed',
  );
  sl.registerFactory<ShapeProduct>(
    () => const Triangle(
        isAnchored: false,
        color: kColorBlue,
        shape: Shapes.TriangleBlue,
        colorFrom: kColorBlueLight,
        colorTo: kColorBlueDark,
        origin: Triangle.shapeOrigin,
        size: Triangle.shapeSize,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.TriangleBlue',
  );
  sl.registerFactory<ShapeProduct>(
    () => const Triangle(
        isAnchored: false,
        color: kColorGreen,
        colorFrom: kColorGreenLight,
        colorTo: kColorGreenDark,
        origin: Triangle.shapeOrigin,
        shape: Shapes.TriangleGreen,
        size: Triangle.shapeSize,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.TriangleGreen',
  );
  sl.registerFactory<ShapeProduct>(
    () => const RectWithoutTriangle(
        isAnchored: false,
        color: kColorOrange,
        colorFrom: kColorYellowPinkLight,
        colorTo: kColorYellowPinkDark,
        origin: RectWithoutTriangle.shapeOrigin,
        size: RectWithoutTriangle.shapeSize,
        shape: Shapes.RectWithoutTriangle,
        positionInList: 1,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.RectWithoutTriangle',
  );

  sl.registerFactory<ShapeProduct>(
    () => const RectWithTriangle(
        isAnchored: false,
        color: kColorOrange,
        colorFrom: kColorBlueLighter,
        colorTo: kColorBlueDarker,
        origin: RectWithTriangle.shapeOrigin,
        size: RectWithTriangle.shapeSize,
        shape: Shapes.RectWithTriangle,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.RectWithTriangle',
  );
  sl.registerFactory<ShapeProduct>(
    () => const Trapezoid(
        isAnchored: false,
        color: kColorOrange,
        colorFrom: kColorRedLight,
        colorTo: kColorRedDark,
        origin: Trapezoid.shapeOrigin,
        size: Trapezoid.shapeSize,
        shape: Shapes.Trapezoid,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    instanceName: 'Shapes.Trapezoid',
  );
  sl.registerFactory<ShapeOrder>(() => ShapeOrder(
        order: <Shapes>[],
      ));

  sl.registerFactory<GameShapes>(() => GameShapes(
        shapes: <Shapes, ShapeProduct>{
          Shapes.TriangleRed: sl(instanceName: 'Shapes.TriangleRed'),
          Shapes.TriangleBlue: sl(instanceName: 'Shapes.TriangleBlue'),
          Shapes.TriangleGreen: sl(instanceName: 'Shapes.TriangleGreen'),
          Shapes.Trapezoid: sl(instanceName: 'Shapes.Trapezoid'),
          Shapes.RectWithTriangle: sl(instanceName: 'Shapes.RectWithTriangle'),
          Shapes.RectWithoutTriangle: sl(instanceName: 'Shapes.RectWithoutTriangle'),
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
