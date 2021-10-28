import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class BillPaymentUsecase extends UseCase<StatusMessageApiResModel, String> {
  final AuthenticationRepository _authenticationRepository;

  BillPaymentUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(String userId) async =>
      _authenticationRepository.billPayment(userId);
}
