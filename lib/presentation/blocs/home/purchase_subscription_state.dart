part of 'purchase_subscription_cubit.dart';

abstract class PurchaseSubscriptionState extends Equatable {
  const PurchaseSubscriptionState();

  @override
  List<Object> get props => [];
}

class PurchaseSubscriptionInitial extends PurchaseSubscriptionState {}

class PurchaseSubscriptionSuccess extends PurchaseSubscriptionState {
  final StatusMessageApiResModel model;

  PurchaseSubscriptionSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class PurchaseSubscriptionError extends PurchaseSubscriptionState {
  final String message;

  PurchaseSubscriptionError(this.message);

  @override
  List<Object> get props => [message];
}
