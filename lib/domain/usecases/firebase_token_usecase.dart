import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/firebase_token_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class FirebaseTokenUsecase extends UseCase<StatusMessageApiResModel, FirebaseTokenParams> {
  final AuthenticationRepository _authenticationRepository;

  FirebaseTokenUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(FirebaseTokenParams params) async =>
      _authenticationRepository.firebaseToken(params.toJson());
}
