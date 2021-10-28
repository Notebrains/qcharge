part of 'firebase_token_cubit.dart';

abstract class FirebaseTokenState extends Equatable {
  const FirebaseTokenState();

  @override
  List<Object> get props => [];
}

class FirebaseTokenInitial extends FirebaseTokenState {}

class FirebaseTokenSuccess extends FirebaseTokenState {
  final StatusMessageApiResModel model;

  FirebaseTokenSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class FirebaseTokenError extends FirebaseTokenState {
  final String message;

  FirebaseTokenError(this.message);

  @override
  List<Object> get props => [message];
}
