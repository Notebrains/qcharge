import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/verify_otp_req_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class VerifyUser extends UseCase<StatusMessageApiResModel, VerifyResParams> {
  final AuthenticationRepository _authenticationRepository;

  VerifyUser(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(VerifyResParams params) async =>
      _authenticationRepository.verifyUser(params.toJson());
}
