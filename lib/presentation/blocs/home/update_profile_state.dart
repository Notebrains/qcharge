part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final StatusMessageApiResModel model;

  UpdateProfileSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class UpdateProfileError extends UpdateProfileState {
  final String message;

  UpdateProfileError(this.message);

  @override
  List<Object> get props => [message];
}
