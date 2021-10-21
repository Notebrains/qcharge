import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/charging_calculation_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class ChargingCalculationUsecase extends UseCase<StatusMessageApiResModel, ChargingCalculationParams> {
  final AuthenticationRepository _authenticationRepository;

  ChargingCalculationUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(ChargingCalculationParams params) async =>
      _authenticationRepository.doChargingCalculation(params.toJson());
}
