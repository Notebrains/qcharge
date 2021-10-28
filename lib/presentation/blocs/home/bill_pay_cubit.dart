import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/usecases/bill_pay_usecase.dart';
import 'package:qcharge_flutter/presentation/blocs/loading/loading_cubit.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';

part 'bill_pay_state.dart';

class BillPaymentCubit extends Cubit<BillPaymentState> {
  final BillPaymentUsecase usecase;
  final LoadingCubit loadingCubit;

  BillPaymentCubit({
    required this.usecase,
    required this.loadingCubit,
  }) : super(BillPaymentInitial());


  void initiateBillPayment(String vehicleId) async {
    loadingCubit.show();
    final Either<AppError, StatusMessageApiResModel> eitherResponse = await usecase(vehicleId);

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return BillPaymentError(message);
      },
          (r) => BillPaymentSuccess(r),
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
