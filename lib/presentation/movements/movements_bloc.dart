import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tangram/business/useCases/get_initial_points.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/shape_enum.dart';

part 'movements_event.dart';
part 'movements_state.dart';

class MovementsBloc extends Bloc<MovementsEvent, MovementsState> {
  final GetPointsUseCase getPoints;
  Shapes focusedShape = Shapes.None;

  MovementsBloc({required this.getPoints})
      : super(InitialPointSystemState(pointsMap: getPoints.getMap()));

  @override
  Stream<MovementsState> mapEventToState(
    MovementsEvent event,
  ) async* {
    if (event is ShapeFocused) {
      focusedShape = event.shape;
    }

    if (event is RotatedRight) {}
  }
}
