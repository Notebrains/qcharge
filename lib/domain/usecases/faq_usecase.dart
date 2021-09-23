import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/faq_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/repositories/authentication_repository.dart';

import '../entities/app_error.dart';
import 'usecase.dart';

class FaqUsecase extends UseCase< FaqApiResModel, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  FaqUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, FaqApiResModel>> call(NoParams params) {
    return _authenticationRepository.getFaqData();
  }
}
