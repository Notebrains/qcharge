part of 'req_otp_cubit.dart';

abstract class ReqOtpState extends Equatable {
  const ReqOtpState();

  @override
  List<Object> get props => [];
}

class ReqOtpInitial extends ReqOtpState {}

class ReqOtpSuccess extends ReqOtpState {
  final StatusMessageApiResModel model;

  ReqOtpSuccess(this.model);

  @override
  List<Object> get props => [model];
}

class ReqOtpError extends ReqOtpState {
  final String message;

  ReqOtpError(this.message);

  @override
  List<Object> get props => [message];
}
