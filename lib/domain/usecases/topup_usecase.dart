import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/entities/top_up_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class TopUp extends UseCase<TopUpApiResModel, TopUpParams> {
  final AuthenticationRepository _authenticationRepository;

  TopUp(this._authenticationRepository);

  @override
  Future<Either<AppError, TopUpApiResModel>> call(TopUpParams params) async =>
      _authenticationRepository.getTopUp(params.toJson());
}
