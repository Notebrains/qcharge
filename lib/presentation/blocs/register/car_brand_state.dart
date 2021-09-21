part of 'car_brand_cubit.dart';

abstract class CarBrandState extends Equatable {
  const CarBrandState();

  @override
  List<Object> get props => [];
}

class CarBrandInitial extends CarBrandState {}

class CarBrandLoading extends CarBrandState {}

class CarBrandError extends CarBrandState {}

class CarBrandLoaded extends CarBrandState {
  final List<CarBrandEntity> carBrandEntity;

  const CarBrandLoaded(this.carBrandEntity);

  @override
  List<Object> get props => [carBrandEntity];
}
