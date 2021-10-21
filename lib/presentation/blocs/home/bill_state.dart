part of 'bill_cubit.dart';

abstract class BillState extends Equatable {
  const BillState();

  @override
  List<Object> get props => [];
}

class BillInitial extends BillState {}

class BillSuccess extends BillState {
  final BillApiResModel model;

  BillSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class BillError extends BillState {
  final String message;

  BillError(this.message);

  @override
  List<Object> get props => [message];
}
