import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/widgets/shapes/rectWithoutTriangleWidget.dart';
import 'package:tangram/presentation/widgets/shapes/shapesWidget.dart';
import 'package:tangram/settings.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/shape_enum.dart';

class AllShapesWidget extends StatelessWidget {
  final Settings settings;
  // final Map<Shapes, List<PointSystem>> points;

  const AllShapesWidget({
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    Map<Shapes, List<PointSystem>> temp1 = {
      Shapes.RectWithTriangle: [],
      Shapes.RectWithoutTriangle: [],
      Shapes.Trapezoid: [],
      Shapes.TriangleRed: [],
      Shapes.TriangleBlue: [],
      Shapes.TriangleGreen: []
    };
    return Stack(fit: StackFit.expand, children: <Widget>[
      BlocBuilder<MovementsBloc, MovementsState>(
        builder: (context, state) {
          if (state is InitialPointSystemState) {
            return TrapezoidWidget(
                x: 1,
                y: 5,
                points: state.pointsMap[Shapes.Trapezoid]!,
                color: settings.color,
                settings: settings);
          }
          return TrapezoidWidget(
              x: 1, y: 5, points: [], color: settings.color, settings: settings);
        },
      ),
      BlocBuilder<MovementsBloc, MovementsState>(
        builder: (context, state) {
          if (state is InitialPointSystemState) {
            return TriangleWidget(
                x: 0,
                y: 0,
                points: state.pointsMap[Shapes.TriangleBlue]!,
                color: settings.color,
                settings: settings,
                shape: Shapes.TriangleBlue);
          }
          return TriangleWidget(
              x: 0,
              y: 0,
              points: [],
              color: settings.color,
              settings: settings,
              shape: Shapes.TriangleBlue);
        },
      ),
      BlocBuilder<MovementsBloc, MovementsState>(
        builder: (context, state) {
          if (state is InitialPointSystemState) {
            return TriangleWidget(
                x: 2,
                y: 0,
                points: state.pointsMap[Shapes.TriangleRed]!,
                color: settings.color,
                settings: settings,
                shape: Shapes.TriangleRed);
          }
          return TriangleWidget(
              x: 2,
              y: 0,
              points: [],
              color: settings.color,
              settings: settings,
              shape: Shapes.TriangleRed);
        },
      ),
      BlocBuilder<MovementsBloc, MovementsState>(
        builder: (context, state) {
          if (state is InitialPointSystemState) {
            return TriangleWidget(
                x: 4,
                y: 0,
                points: state.pointsMap[Shapes.TriangleGreen]!,
                color: settings.color,
                settings: settings,
                shape: Shapes.TriangleGreen);
          }
          return TriangleWidget(
              x: 4,
              y: 0,
              points: [],
              color: settings.color,
              settings: settings,
              shape: Shapes.TriangleGreen);
        },
      ),
      BlocBuilder<MovementsBloc, MovementsState>(
        buildWhen: (prev, state) {
          log.wtf('previous: $prev current: $state');
          return true;
        },
        builder: (context, state) {
          if (state is InitialPointSystemState) {
            return RectWithTriangleWidget(
                x: 5,
                y: 0,
                points: state.pointsMap[Shapes.RectWithTriangle]!,
                color: settings.color,
                settings: settings);
          }
          return RectWithTriangleWidget(
              x: 5, y: 0, points: [], color: settings.color, settings: settings);
        },
      ),
      BlocBuilder<MovementsBloc, MovementsState>(
        builder: (context, state) {
          if (state is InitialPointSystemState) {
            return RectWithoutTriangleWidget(
                x: 1,
                y: 11,
                points: state.pointsMap[Shapes.RectWithoutTriangle]!,
                color: settings.color,
                settings: settings);
          }
          return RectWithoutTriangleWidget(
              x: 1, y: 5, points: [], color: settings.color, settings: settings);
        },
      ),
    ]);
  }
}
