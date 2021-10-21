import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/bill_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class BillUsecase extends UseCase<BillApiResModel, String> {
  final AuthenticationRepository _authenticationRepository;

  BillUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, BillApiResModel>> call(String userId) async =>
      _authenticationRepository.getBills(userId);
}
