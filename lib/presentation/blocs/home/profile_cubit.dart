import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/profile_api_res_model.dart';
import 'package:qcharge_flutter/domain/usecases/profile_usecase.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final Profile profile;

  ProfileCubit({
    required this.profile,
  }) : super(ProfileInitial());


  void initiateProfile(String userId) async {

    final Either<AppError, ProfileApiResModel> eitherResponse = await profile(userId);

    emit(eitherResponse.fold((l) {
      var message = getErrorMessage(l.appErrorType);
      print(message);
      return ProfileError(message);
    }, (r) {

      return ProfileSuccess(r);
      },
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
