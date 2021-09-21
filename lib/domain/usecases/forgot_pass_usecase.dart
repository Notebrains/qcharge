import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/forgot_pass_api_res_model.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class ForgotPassword extends UseCase<ForgotPassApiResModel, String> {
  final AuthenticationRepository _authenticationRepository;

  ForgotPassword(this._authenticationRepository);

  @override
  Future<Either<AppError, ForgotPassApiResModel>> call(String mobile) async =>
      _authenticationRepository.getForgotPassword(mobile);
}
