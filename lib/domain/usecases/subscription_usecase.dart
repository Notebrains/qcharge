import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/subscription_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class Subscription extends UseCase<SubscriptionApiResModel, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  Subscription(this._authenticationRepository);

  @override
  Future<Either<AppError, SubscriptionApiResModel>> call(NoParams noParams) async =>
      _authenticationRepository.getSubscription();
}
