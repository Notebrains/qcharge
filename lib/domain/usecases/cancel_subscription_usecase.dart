import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/cancel_subscription_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class CancelSubscription extends UseCase<StatusMessageApiResModel, CancelSubscriptionParams> {
  final AuthenticationRepository _authenticationRepository;

  CancelSubscription(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(CancelSubscriptionParams params) async =>
      _authenticationRepository.cancelSubscription(params.toJson());
}
