part of 'verify_cubit.dart';

abstract class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object> get props => [];
}

class VerifyInitial extends VerifyState {}

class VerifySuccess extends VerifyState {
  final StatusMessageApiResModel model;

  VerifySuccess(this.model);

  @override
  List<Object> get props => [model];
}

class VerifyError extends VerifyState {
  final String message;

  VerifyError(this.message);

  @override
  List<Object> get props => [message];
}
