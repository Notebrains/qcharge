import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/faq_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/usecases/faq_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final FaqUsecase faq;
  final LoadingCubit loadingCubit;

  FaqCubit({
    required this.faq,
    required this.loadingCubit,
  }) : super(FaqInitial());
  void initiateFaq(
      String mobile,
      String otp,
      ) async {
    loadingCubit.show();
    final Either<AppError, FaqApiResModel> eitherResponse = await faq(NoParams());

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return FaqError(message);
      },
          (r) => FaqSuccess(r),
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
