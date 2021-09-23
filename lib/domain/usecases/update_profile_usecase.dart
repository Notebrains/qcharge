import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/update_profile_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class UpdateProfileUser extends UseCase<StatusMessageApiResModel, UpdateProfileParams> {
  final AuthenticationRepository _authenticationRepository;

  UpdateProfileUser(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(UpdateProfileParams params) async =>
      _authenticationRepository.updateProfile(params.toJson());
}
