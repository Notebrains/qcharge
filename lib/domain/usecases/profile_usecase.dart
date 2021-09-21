import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/profile_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class Profile extends UseCase<ProfileApiResModel, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  Profile(this._authenticationRepository);

  @override
  Future<Either<AppError, ProfileApiResModel>> call(NoParams params) async =>
      _authenticationRepository.getProfile("1");
}
