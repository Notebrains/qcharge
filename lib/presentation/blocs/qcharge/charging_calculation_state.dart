part of 'charging_calculation_cubit.dart';

abstract class ChargingCalculationState extends Equatable {
  const ChargingCalculationState();

  @override
  List<Object> get props => [];
}

class ChargingCalculationInitial extends ChargingCalculationState {}

class ChargingCalculationSuccess extends ChargingCalculationState {
  final StatusMessageApiResModel model;

  ChargingCalculationSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class ChargingCalculationError extends ChargingCalculationState {
  final String message;

  ChargingCalculationError(this.message);

  @override
  List<Object> get props => [message];
}
