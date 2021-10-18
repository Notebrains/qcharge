import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/add_update_cars_params.dart';
import 'package:qcharge_flutter/domain/entities/update_profile_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class AddUpdateCarUsecase extends UseCase<StatusMessageApiResModel, AddUpdateCarParams> {
  final AuthenticationRepository _authenticationRepository;

  AddUpdateCarUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(AddUpdateCarParams params) async =>
      _authenticationRepository.addUpdateCar(params.toJson());
}
