import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/data/models/map_api_res_model.dart';
import 'package:qcharge_flutter/data/models/station_details_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class MapStationDetailsUsecase extends UseCase<StationDetailsApiResModel, String> {
  final AuthenticationRepository _authenticationRepository;

  MapStationDetailsUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, StationDetailsApiResModel>> call(String stationId) async =>
      _authenticationRepository.getStationDetailsOnMap(stationId);
}
