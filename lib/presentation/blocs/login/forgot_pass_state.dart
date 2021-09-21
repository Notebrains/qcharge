part of 'forgot_pass_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPassApiResModel model;

  ForgotPasswordSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  ForgotPasswordError(this.message);

  @override
  List<Object> get props => [message];
}
