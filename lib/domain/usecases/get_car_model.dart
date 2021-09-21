import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/repositories/authentication_repository.dart';

import '../entities/app_error.dart';
import 'usecase.dart';

class CarModel extends UseCase<List<CarBrandEntity>, String> {
  final AuthenticationRepository _authenticationRepository;

  CarModel(this._authenticationRepository);

  @override
  Future<Either<AppError, List<CarBrandEntity>>> call(String id) {
    return _authenticationRepository.getCarModel(id);
  }
}
