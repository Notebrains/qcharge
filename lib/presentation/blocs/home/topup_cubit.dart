import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';
import 'package:qcharge_flutter/domain/usecases/send_otp.dart';
import 'package:qcharge_flutter/domain/usecases/topup_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'topup_state.dart';

class TopUpCubit extends Cubit<TopUpState> {
  final TopUp topUp;

  TopUpCubit({
    required this.topUp,
  }) : super(TopUpInitial());


  void initiateTopUp(String userId) async {
    final Either<AppError, TopUpApiResModel> eitherResponse = await topUp(userId);

    emit(eitherResponse.fold((l) {
      var message = getErrorMessage(l.appErrorType);
      print(message);
      return TopUpError(message);
    },
          (r) => TopUpSuccess(r),
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
