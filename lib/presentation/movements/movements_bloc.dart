import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movements_event.dart';
part 'movements_state.dart';

class MovementsBloc extends Bloc<MovementsEvent, MovementsState> {
  MovementsBloc() : super(MovementsInitial());

  @override
  Stream<MovementsState> mapEventToState(
    MovementsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
