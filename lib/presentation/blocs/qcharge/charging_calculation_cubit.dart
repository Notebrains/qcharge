import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/charging_calculation_params.dart';
import 'package:qcharge_flutter/domain/usecases/charging_calculation_usecase.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'charging_calculation_state.dart';

class ChargingCalculationCubit extends Cubit<ChargingCalculationState> {
  final ChargingCalculationUsecase usecase;
  final LoadingCubit loadingCubit;

  ChargingCalculationCubit({
    required this.usecase,
    required this.loadingCubit,
  }) : super(ChargingCalculationInitial());

  void initiateChargingCalculation(
      String userId,
      String chargingDispute,
      ) async {
    loadingCubit.show();
    final Either<AppError, StatusMessageApiResModel> eitherResponse = await usecase(
      ChargingCalculationParams(
        userId: userId,
        chargingDispute: chargingDispute,
      ),
    );

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return ChargingCalculationError(message);
      },
          (r) => ChargingCalculationSuccess(r),
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
