part of 'topup_cubit.dart';


abstract class TopUpState extends Equatable {
  const TopUpState();

  @override
  List<Object> get props => [];
}

class TopUpInitial extends TopUpState {}

class TopUpSuccess extends TopUpState {
  final TopUpApiResModel model;

  TopUpSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class TopUpError extends TopUpState {
  final String message;

  TopUpError(this.message);

  @override
  List<Object> get props => [message];
}
