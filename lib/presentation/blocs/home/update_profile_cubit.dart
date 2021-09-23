import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/register_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/register_request_params.dart';
import 'package:qcharge_flutter/domain/entities/update_profile_params.dart';
import 'package:qcharge_flutter/domain/usecases/register_user.dart';
import 'package:qcharge_flutter/domain/usecases/update_profile_usecase.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/usecases/logout_user.dart';
import '../loading/loading_cubit.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUser updateProfileUser;
  final LoadingCubit loadingCubit;

  UpdateProfileCubit({
    required this.updateProfileUser,
    required this.loadingCubit,
  }) : super(UpdateProfileInitial());

  void initiateUpdateProfile(
      String firstName,
      String lastName,
      String email,
      String mobile,
      String password,
      String confirmPassword,
      ) async {
    loadingCubit.show();
    final Either<AppError, StatusMessageApiResModel> eitherResponse = await updateProfileUser(
      UpdateProfileParams(
        mobile: mobile,
        password: password,
      ),
    );

    emit(eitherResponse.fold(
          (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return UpdateProfileError(message);
      },
          (r) => UpdateProfileSuccess(r),
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
