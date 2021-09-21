import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/profile_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/send_otp_req_params.dart';
import 'package:qcharge_flutter/domain/usecases/profile_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/send_otp.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../loading/loading_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final Profile profile;

  ProfileCubit({
    required this.profile,
  }) : super(ProfileInitial());


  void initiateProfile(String mobile) async {
    final Either<AppError, ProfileApiResModel> eitherResponse = await profile(NoParams());

    emit(eitherResponse.fold((l) {
      var message = getErrorMessage(l.appErrorType);
      print(message);
      return ProfileError(message);
    },
          (r) => ProfileSuccess(r),
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
