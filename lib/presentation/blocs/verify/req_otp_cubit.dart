import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';
import 'package:qcharge_flutter/domain/usecases/send_otp.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'req_otp_state.dart';

class ReqOtpCubit extends Cubit<ReqOtpState> {
  final SendOtp sendOtp;
  final LoadingCubit loadingCubit;

  ReqOtpCubit({
    required this.sendOtp,
    required this.loadingCubit,
  }) : super(ReqOtpInitial());


  void initiateSendOtp(String mobile) async {
    loadingCubit.show();
    final Either<AppError, StatusMessageApiResModel> eitherResponse = await sendOtp(
      SendOtpReqParams(
        mobile: mobile,
      ),
    );

    emit(eitherResponse.fold((l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return ReqOtpError(message);
      },
          (r) => ReqOtpSuccess(r),
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
