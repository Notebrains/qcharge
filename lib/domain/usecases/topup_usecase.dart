import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class TopUp extends UseCase<TopUpApiResModel, String> {
  final AuthenticationRepository _authenticationRepository;

  TopUp(this._authenticationRepository);

  @override
  Future<Either<AppError, TopUpApiResModel>> call(String userId) async =>
      _authenticationRepository.getTopUp(userId);
}
