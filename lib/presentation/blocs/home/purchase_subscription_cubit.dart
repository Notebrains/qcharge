import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/purchase_subscription_params.dart';
import 'package:qcharge_flutter/domain/usecases/purchase_subscription_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'purchase_subscription_state.dart';


class PurchaseSubscriptionCubit extends Cubit<PurchaseSubscriptionState> {
  final PurchaseSubscriptionUsecase subscriptionUser;
  final LoadingCubit loadingCubit;

  PurchaseSubscriptionCubit({
    required this.subscriptionUser,
    required this.loadingCubit,
  }) : super(PurchaseSubscriptionInitial());

  void initiatePurchaseSubscription(
      String userId,
      String transactionId,
      String amount,
      String flag,
      String planId,
      ) async {
    loadingCubit.show();
    final Either<AppError, StatusMessageApiResModel> eitherResponse =
    await subscriptionUser(
      PurchaseSubscriptionParams(
        userId: userId,
        transactionId: transactionId,
        amount: amount,
        flag: flag,
        planId: planId,
      ),
    );

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return PurchaseSubscriptionError(message);
      },
          (r) => PurchaseSubscriptionSuccess(r),
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
