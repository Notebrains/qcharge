import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/home_card_api_res_model.dart';
import 'package:qcharge_flutter/domain/usecases/home_card_usecase.dart';
import 'package:qcharge_flutter/presentation/blocs/loading/loading_cubit.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';

part 'home_card_state.dart';

class HomeCardCubit extends Cubit<HomeCardState> {
  final HomeCard homeCard;
  final LoadingCubit loadingCubit;

  HomeCardCubit({
    required this.homeCard,
    required this.loadingCubit,
  }) : super(HomeCardInitial());


  void initiateHomeCard(String contentEndpoint) async {
    loadingCubit.show();
    final Either<AppError, HomeCardApiResModel> eitherResponse = await homeCard(contentEndpoint);
    loadingCubit.hide();
    emit(eitherResponse.fold(
          (l) {
                var message = getErrorMessage(l.appErrorType);
                print(message);
                return HomeCardError(message);
    },
          (r) => HomeCardSuccess(r),
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

