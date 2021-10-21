part of 'cancel_subscription_cubit.dart';

abstract class CancelSubscriptionState extends Equatable {
  const CancelSubscriptionState();

  @override
  List<Object> get props => [];
}

class CancelSubscriptionInitial extends CancelSubscriptionState {}

class CancelSubscriptionSuccess extends CancelSubscriptionState {
  final StatusMessageApiResModel model;

  CancelSubscriptionSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class CancelSubscriptionError extends CancelSubscriptionState {
  final String message;

  CancelSubscriptionError(this.message);

  @override
  List<Object> get props => [message];
}
