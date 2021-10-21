import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/register_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/register_request_params.dart';
import 'package:qcharge_flutter/domain/usecases/register_user.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/usecases/logout_user.dart';
import '../loading/loading_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUser registerUser;
  final LoadingCubit loadingCubit;

  RegisterCubit({
    required this.registerUser,
    required this.loadingCubit,
  }) : super(RegisterInitial());

  void initiateRegister(
      String firstName,
      String lastName,
      String email,
      String mobile,
      String password,
      String confirmPassword,
      String carName,
      String brand,
      String carModel,
      String carLicencePlate,
      String image,
      ) async {
    loadingCubit.show();
    final Either<AppError, RegisterApiResModel> eitherResponse = await registerUser(
      RegisterRequestParams(
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        password: password,
        carName: carName,
        confirmPassword: confirmPassword,
        email: email,
        carLicencePlate: carLicencePlate,
        carModel: carModel,
        brand: brand,
        image: image,
      ),
    );

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return RegisterError(message);
      },
      (r) => RegisterSuccess(r),
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
