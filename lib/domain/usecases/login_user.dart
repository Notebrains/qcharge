import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/login_api_res_model.dart';

import '../entities/app_error.dart';
import '../entities/login_request_params.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class LoginUser extends UseCase<LoginApiResModel, LoginRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  LoginUser(this._authenticationRepository);

  @override
  Future<Either<AppError, LoginApiResModel>> call(LoginRequestParams params) async =>
      _authenticationRepository.loginUser(params.toJson());
}
