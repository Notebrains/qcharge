import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/cancel_subscription_params.dart';
import 'package:qcharge_flutter/domain/entities/purchase_subscription_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class PurchaseSubscriptionUsecase extends UseCase<StatusMessageApiResModel, PurchaseSubscriptionParams> {
  final AuthenticationRepository _authenticationRepository;

  PurchaseSubscriptionUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, StatusMessageApiResModel>> call(PurchaseSubscriptionParams params) async =>
      _authenticationRepository.purchaseSubscription(params.toJson());
}
