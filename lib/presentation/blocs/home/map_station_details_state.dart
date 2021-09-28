part of 'map_station_details_cubit.dart';


abstract class MapStationDetailsState extends Equatable {
  const MapStationDetailsState();

  @override
  List<Object> get props => [];
}

class MapStationDetailsInitial extends MapStationDetailsState {}

class MapStationDetailsSuccess extends MapStationDetailsState {
  final StationDetailsApiResModel stationDetailsApiResModel;

  MapStationDetailsSuccess(this.stationDetailsApiResModel);

  @override
  List<Object> get props => [stationDetailsApiResModel];
}

class MapStationDetailsError extends MapStationDetailsState {
  final String message;

  MapStationDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
