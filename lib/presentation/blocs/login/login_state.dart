part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginApiResModel model;

  LoginSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class LogoutSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteUserSuccess extends LoginState {
  final StatusMessageApiResModel model;

  DeleteUserSuccess(this.model);

  @override
  List<Object> get props => [model];
}

