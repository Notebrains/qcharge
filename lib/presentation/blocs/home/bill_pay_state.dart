part of 'bill_pay_cubit.dart';

abstract class BillPaymentState extends Equatable {
  const BillPaymentState();

  @override
  List<Object> get props => [];
}

class BillPaymentInitial extends BillPaymentState {}

class BillPaymentSuccess extends BillPaymentState {
  final StatusMessageApiResModel model;

  BillPaymentSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class BillPaymentError extends BillPaymentState {
  final String message;

  BillPaymentError(this.message);

  @override
  List<Object> get props => [message];
}
