part of 'map_cubit.dart';


abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapSuccess extends MapState {
  final MapApiResModel model;

  MapSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class MapError extends MapState {
  final String message;

  MapError(this.message);

  @override
  List<Object> get props => [message];
}
