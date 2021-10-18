part of 'add_update_car_cubit.dart';

abstract class AddUpdateCarState extends Equatable {
  const AddUpdateCarState();

  @override
  List<Object> get props => [];
}

class AddUpdateCarInitial extends AddUpdateCarState {}

class AddUpdateCarSuccess extends AddUpdateCarState {
  final StatusMessageApiResModel model;

  AddUpdateCarSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class AddUpdateCarError extends AddUpdateCarState {
  final String message;

  AddUpdateCarError(this.message);

  @override
  List<Object> get props => [message];
}
