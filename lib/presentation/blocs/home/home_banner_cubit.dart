import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';
import 'package:qcharge_flutter/domain/entities/verify_otp_req_params.dart';
import 'package:qcharge_flutter/domain/usecases/home_banner.dart';
import 'package:qcharge_flutter/domain/usecases/send_otp.dart';
import 'package:qcharge_flutter/domain/usecases/verify_user.dart';
import 'package:qcharge_flutter/presentation/blocs/appblocks/firebase_token_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/map_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/profile_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/topup_cubit.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'home_banner_state.dart';

class HomeBannerCubit extends Cubit<HomeBannerState> {
  final HomeBanner homeBanner;
  final ProfileCubit profileCubit;
  final TopUpCubit topUpCubit;
  final LoadingCubit loadingCubit;
  final MapCubit mapCubit;
  final FirebaseTokenCubit firebaseTokenCubit;

  HomeBannerCubit({
    required this.homeBanner,
    required this.profileCubit,
    required this.topUpCubit,
    required this.loadingCubit,
    required this.mapCubit,
    required this.firebaseTokenCubit,
  }) : super(HomeBannerInitial());

  void initiateHomeBanner() async {
    loadingCubit.show();
    final Either<AppError, HomeBannerApiResModel> eitherResponse = await homeBanner(NoParams());

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return HomeBannerError(message);
      },
      (r) => HomeBannerSuccess(r),
    ));

    await AuthenticationLocalDataSourceImpl().getSessionId().then((userId) => {
      print('---- user id 1: $userId'),
      if (userId != null) {
        profileCubit.initiateProfile(userId),
        mapCubit.initiateMap(),
        topUpCubit.initiateTopUp(userId, formatDateForTopUp(DateTime.now())),
        firebaseTokenCubit.initiateFirebaseToken(userId),
      }
    });

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
