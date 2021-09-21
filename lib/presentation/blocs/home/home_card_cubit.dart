import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/home_card_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';
import 'package:qcharge_flutter/domain/entities/verify_otp_req_params.dart';
import 'package:qcharge_flutter/domain/usecases/home_card.dart';
import 'package:qcharge_flutter/domain/usecases/send_otp.dart';
import 'package:qcharge_flutter/domain/usecases/verify_user.dart';
import 'package:qcharge_flutter/presentation/blocs/home/profile_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/topup_cubit.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'home_card_state.dart';

class HomeCardCubit extends Cubit<HomeCardState> {
  final HomeCard homeCard;
  final ProfileCubit profileCubit;
  final TopUpCubit topUpCubit;
  final LoadingCubit loadingCubit;

  HomeCardCubit({
    required this.homeCard,
    required this.profileCubit,
    required this.topUpCubit,
    required this.loadingCubit,
  }) : super(HomeCardInitial());

  void initiateHomeCard() async {
    loadingCubit.show();
    final Either<AppError, HomeCardApiResModel> eitherResponse = await homeCard(NoParams());

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return HomeCardError(message);
      },
      (r) => HomeCardSuccess(r),
    ));
    profileCubit.initiateProfile('1'); //change here
    topUpCubit.initiateTopUp('9564636037');
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
