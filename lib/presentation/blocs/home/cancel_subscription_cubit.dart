import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/subscription_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/cancel_subscription_params.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/usecases/cancel_subscription_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/subscription_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'cancel_subscription_state.dart';

class CancelSubscriptionCubit extends Cubit<CancelSubscriptionState> {
  final CancelSubscription subscriptionUser;
  final LoadingCubit loadingCubit;

  CancelSubscriptionCubit({
    required this.subscriptionUser,
    required this.loadingCubit,
  }) : super(CancelSubscriptionInitial());

  void initiateCancelSubscription(String userId, String subscriptionId) async {
    loadingCubit.show();
    final Either<AppError, StatusMessageApiResModel> eitherResponse = await subscriptionUser(CancelSubscriptionParams(
      userId: userId,
      subscriptionId: subscriptionId,
    ));

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return CancelSubscriptionError(message);
      },
          (r) => CancelSubscriptionSuccess(r),
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
