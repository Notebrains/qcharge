import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';

import '../entities/app_error.dart';
import '../entities/no_params.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class DeleteUser extends UseCase<StatusMessageApiResModel, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  DeleteUser(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(NoParams noParams) async =>
      _authenticationRepository.deleteUser();
}
