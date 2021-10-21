import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/subscription_api_res_model.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class Subscription extends UseCase<SubscriptionApiResModel, String> {
  final AuthenticationRepository _authenticationRepository;

  Subscription(this._authenticationRepository);

  @override
  Future<Either<AppError, SubscriptionApiResModel>> call(String userId) async =>
      _authenticationRepository.getSubscription(userId);
}
