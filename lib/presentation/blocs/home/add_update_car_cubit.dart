import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/register_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/add_update_cars_params.dart';
import 'package:qcharge_flutter/domain/entities/register_request_params.dart';
import 'package:qcharge_flutter/domain/entities/update_profile_params.dart';
import 'package:qcharge_flutter/domain/usecases/add_update_car_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/register_user.dart';
import 'package:qcharge_flutter/domain/usecases/update_profile_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/usecases/logout_user.dart';
import '../loading/loading_cubit.dart';

part 'add_update_car_state.dart';

class AddUpdateCarCubit extends Cubit<AddUpdateCarState> {
  final AddUpdateCarUsecase addUpdateCarUsecase;
  final LoadingCubit loadingCubit;

  AddUpdateCarCubit({
    required this.addUpdateCarUsecase,
    required this.loadingCubit,
  }) : super(AddUpdateCarInitial());

  void initiateAddUpdateCar(
      String userID,
      String brand,
      String model,
      String carName,
      String carLicencePlate,
      String vehicleId,
      String type,
      String image,
      ) async {
    loadingCubit.show();

    print('---- : $userID , $brand, $model, $carName, $carLicencePlate, $vehicleId, $type, $image,');

    final Either<AppError, StatusMessageApiResModel> eitherResponse = await addUpdateCarUsecase(
      AddUpdateCarParams(
        userID: userID,
        brand: brand,
        model: model,
        carName: carName,
        carLicencePlate: carLicencePlate,
        vehicleId: vehicleId,
        type: type,
        image: image,
      ),
    );

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return AddUpdateCarError(message);
      },
          (r) => AddUpdateCarSuccess(r),
    ));
    loadingCubit.hide();
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
