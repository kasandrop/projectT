part of 'movements_bloc.dart';

abstract class MovementsState extends Equatable {
  const MovementsState();
}

class MovementsInitial extends MovementsState {
  @override
  List<Object> get props => [];
}
