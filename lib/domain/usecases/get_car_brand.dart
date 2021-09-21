import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/repositories/authentication_repository.dart';

import '../entities/app_error.dart';
import 'usecase.dart';

class CarBrand extends UseCase<List<CarBrandEntity>, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  CarBrand(this._authenticationRepository);

  @override
  Future<Either<AppError, List<CarBrandEntity>>> call(NoParams params) {
    return _authenticationRepository.getCarBrand();
  }
}
