import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/forgot_pass_api_res_model.dart';
import 'package:qcharge_flutter/data/models/home_card_api_res_model.dart';
import 'package:qcharge_flutter/data/models/profile_api_res_model.dart';
import 'package:qcharge_flutter/data/models/register_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';

import '../entities/app_error.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> params);
  Future<Either<AppError, void>> logoutUser();
  Future<Either<AppError, RegisterApiResModel>> registerUser(Map<String, dynamic> params);
  Future<Either<AppError, StatusMessageApiResModel>> verifyUser(Map<String, dynamic> params);
  Future<Either<AppError, StatusMessageApiResModel>> sendOtp(Map<String, dynamic> params);
  Future<Either<AppError, List<CarBrandEntity>>> getCarBrand();
  Future<Either<AppError, List<CarBrandEntity>>> getCarModel(String id);
  Future<Either<AppError, ProfileApiResModel>> getProfile(String userId);
  Future<Either<AppError, HomeCardApiResModel>> getHomeCardData();
  Future<Either<AppError, TopUpApiResModel>> getTopUp(String userId);
  Future<Either<AppError, ForgotPassApiResModel>> getForgotPassword(String mobile);

}
