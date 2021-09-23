part of 'subscription_cubit.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionSuccess extends SubscriptionState {
  final SubscriptionApiResModel model;

  SubscriptionSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class SubscriptionError extends SubscriptionState {
  final String message;

  SubscriptionError(this.message);

  @override
  List<Object> get props => [message];
}
