import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/bill_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/usecases/bill_usecase.dart';
import 'package:qcharge_flutter/presentation/blocs/loading/loading_cubit.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  final BillUsecase billUsecase;
  final LoadingCubit loadingCubit;

  BillCubit({
    required this.billUsecase,
    required this.loadingCubit,
  }) : super(BillInitial());


  void initiateBill(String userId) async {
    loadingCubit.show();
    final Either<AppError, BillApiResModel> eitherResponse = await billUsecase(userId);

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return BillError(message);
      },
          (r) => BillSuccess(r),
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
