import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/data/models/map_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class MapUsecase extends UseCase<MapApiResModel, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  MapUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, MapApiResModel>> call(NoParams params) async =>
      _authenticationRepository.getMapLocations();
}
