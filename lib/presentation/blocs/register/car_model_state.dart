part of 'car_model_cubit.dart';

abstract class CarModelState extends Equatable {
  const CarModelState();

  @override
  List<Object> get props => [];
}

class CarModelInitial extends CarModelState {}

class CarModelLoading extends CarModelState {}

class CarModelError extends CarModelState {}

class CarModelLoaded extends CarModelState {
  final List<CarBrandEntity> carModelEntity;

  const CarModelLoaded(this.carModelEntity);

  @override
  List<Object> get props => [carModelEntity];
}
