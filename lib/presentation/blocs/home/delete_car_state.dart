part of 'delete_car_cubit.dart';

abstract class DeleteCarState extends Equatable {
  const DeleteCarState();

  @override
  List<Object> get props => [];
}

class DeleteCarInitial extends DeleteCarState {}

class DeleteCarSuccess extends DeleteCarState {
  final StatusMessageApiResModel model;

  DeleteCarSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class DeleteCarError extends DeleteCarState {
  final String message;

  DeleteCarError(this.message);

  @override
  List<Object> get props => [message];
}
