import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/bill_api_res_model.dart';
import 'package:qcharge_flutter/data/models/faq_api_res_model.dart';
import 'package:qcharge_flutter/data/models/forgot_pass_api_res_model.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/data/models/home_card_api_res_model.dart';
import 'package:qcharge_flutter/data/models/login_api_res_model.dart';
import 'package:qcharge_flutter/data/models/map_api_res_model.dart';
import 'package:qcharge_flutter/data/models/profile_api_res_model.dart';
import 'package:qcharge_flutter/data/models/register_api_res_model.dart';
import 'package:qcharge_flutter/data/models/station_details_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/subscription_api_res_model.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';

import '../entities/app_error.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, LoginApiResModel>> loginUser(Map<String, dynamic> params);

  Future<Either<AppError, void>> logoutUser();

  Future<Either<AppError, RegisterApiResModel>> registerUser(Map<String, dynamic> params);

  Future<Either<AppError, StatusMessageApiResModel>> verifyUser(Map<String, dynamic> params);

  Future<Either<AppError, StatusMessageApiResModel>> sendOtp(Map<String, dynamic> params);

  Future<Either<AppError, List<CarBrandEntity>>> getCarBrand();

  Future<Either<AppError, List<CarBrandEntity>>> getCarModel(String id);

  Future<Either<AppError, ProfileApiResModel>> getProfile(String userId);

  Future<Either<AppError, HomeBannerApiResModel>> getHomeBannerData();

  Future<Either<AppError, TopUpApiResModel>> getTopUp(Map<String, dynamic> params);

  Future<Either<AppError, ForgotPassApiResModel>> getForgotPassword(String mobile);

  Future<Either<AppError, FaqApiResModel>> getFaqData();

  Future<Either<AppError, HomeCardApiResModel>> getHomeCardData(String contentEndpoint);

  Future<Either<AppError, StatusMessageApiResModel>> updateProfile(Map<String, dynamic> params);

  Future<Either<AppError, SubscriptionApiResModel>> getSubscription(String userId);

  Future<Either<AppError, MapApiResModel>> getMapLocations();

  Future<Either<AppError, StationDetailsApiResModel>> getStationDetailsOnMap(String stationId);

  Future<Either<AppError, StatusMessageApiResModel>> deleteCar(String vehicleId);

  Future<Either<AppError, StatusMessageApiResModel>> addUpdateCar(Map<String, dynamic> params);

  Future<Either<AppError, StatusMessageApiResModel>> cancelSubscription(Map<String, dynamic> params);

  Future<Either<AppError, StatusMessageApiResModel>> purchaseSubscription(Map<String, dynamic> json);

  Future<Either<AppError, StatusMessageApiResModel>> walletRecharge(Map<String, dynamic> params);

  Future<Either<AppError, BillApiResModel>> getBills(String userId);

  Future<Either<AppError, StatusMessageApiResModel>> doChargingCalculation(Map<String, dynamic> params);
}
