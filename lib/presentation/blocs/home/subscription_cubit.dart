import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/subscription_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/usecases/subscription_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final Subscription subscriptionUser;
  final LoadingCubit loadingCubit;

  SubscriptionCubit({
    required this.subscriptionUser,
    required this.loadingCubit,
  }) : super(SubscriptionInitial());

  void initiateSubscription() async {
    loadingCubit.show();
    final Either<AppError, SubscriptionApiResModel> eitherResponse = await subscriptionUser(NoParams());

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return SubscriptionError(message);
      },
          (r) => SubscriptionSuccess(r),
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
