import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class DeleteCarUsecase extends UseCase<StatusMessageApiResModel, String> {
  final AuthenticationRepository _authenticationRepository;

  DeleteCarUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(String vehicleId) async =>
      _authenticationRepository.deleteCar(vehicleId);
}
