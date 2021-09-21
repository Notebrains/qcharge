import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/register_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/register_request_params.dart';

import '../entities/app_error.dart';
import '../entities/login_request_params.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class RegisterUser extends UseCase<RegisterApiResModel, RegisterRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUser(this._authenticationRepository);

  @override
  Future<Either<AppError, RegisterApiResModel>> call(RegisterRequestParams params) async =>
      _authenticationRepository.registerUser(params.toJson());
}
