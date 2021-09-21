import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class SendOtp extends UseCase<StatusMessageApiResModel, SendOtpReqParams> {
  final AuthenticationRepository _authenticationRepository;

  SendOtp(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(SendOtpReqParams params) async =>
      _authenticationRepository.sendOtp(params.toJson());
}
