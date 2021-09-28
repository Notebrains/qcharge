import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/map_api_res_model.dart';
import 'package:qcharge_flutter/data/models/station_details_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';
import 'package:qcharge_flutter/domain/entities/top_up_params.dart';
import 'package:qcharge_flutter/domain/usecases/map_station_details_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/map_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/send_otp.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapUsecase mapUsecase;

  MapCubit({
    required this.mapUsecase,
  }) : super(MapInitial());


  void initiateMap() async {
    final Either<AppError, MapApiResModel> eitherResponse = await mapUsecase(NoParams());

    emit(eitherResponse.fold((l) {
      var message = getErrorMessage(l.appErrorType);
      print(message);
      return MapError(message);
    },
          (r) => MapSuccess(r),
    ));
  }




  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
