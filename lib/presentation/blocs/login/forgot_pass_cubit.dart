import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/forgot_pass_api_res_model.dart';
import 'package:qcharge_flutter/domain/usecases/forgot_pass_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';

part 'forgot_pass_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPassword forgotPassword;

  ForgotPasswordCubit({
    required this.forgotPassword,
  }) : super(ForgotPasswordInitial());


  void initiateForgotPassword(String mobile) async {
    final Either<AppError, ForgotPassApiResModel> eitherResponse = await forgotPassword(mobile);

    emit(eitherResponse.fold(
          (l) {
                var message = getErrorMessage(l.appErrorType);
                print(message);
                return ForgotPasswordError(message);
              },
          (r) => ForgotPasswordSuccess(r),
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
