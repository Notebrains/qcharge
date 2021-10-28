part of 'wallet_recharge_cubit.dart';

abstract class WalletRechargeState extends Equatable {
  const WalletRechargeState();

  @override
  List<Object> get props => [];
}

class WalletRechargeInitial extends WalletRechargeState {}

class WalletRechargeSuccess extends WalletRechargeState {
  final WalletRechargeApiRes model;

  WalletRechargeSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class WalletRechargeError extends WalletRechargeState {
  final String message;

  WalletRechargeError(this.message);

  @override
  List<Object> get props => [message];
}
