import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/car_brand_model.dart';
import 'package:qcharge_flutter/data/models/faq_api_res_model.dart';
import 'package:qcharge_flutter/data/models/forgot_pass_api_res_model.dart';
import 'package:qcharge_flutter/data/models/home_banner_api_res_model.dart';
import 'package:qcharge_flutter/data/models/home_card_api_res_model.dart';
import 'package:qcharge_flutter/data/models/profile_api_res_model.dart';
import 'package:qcharge_flutter/data/models/register_api_res_model.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/subscription_api_res_model.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';

import '../../domain/entities/app_error.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../core/unathorised_exception.dart';
import '../data_sources/authentication_local_data_source.dart';
import '../data_sources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._authenticationLocalDataSource,
  );

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> body) async {
    try {
      //body.putIfAbsent('mobile', () => '9732508414');
      //body.putIfAbsent('password', () => '12345678');
      final login = await _authenticationRemoteDataSource.doLogin(body);

      await _authenticationLocalDataSource.saveSessionId(login.response!.userId.toString());
      return Right(true);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, StatusMessageApiResModel>> verifyUser(Map<String, dynamic> body) async {
    try {
      final response = await _authenticationRemoteDataSource.doVerifyUser(body);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, StatusMessageApiResModel>> sendOtp(Map<String, dynamic> body) async {
    try {
      final response = await _authenticationRemoteDataSource.doSendOtp(body);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, RegisterApiResModel>> registerUser(Map<String, dynamic> body) async {
    try {
      final register = await _authenticationRemoteDataSource.doRegister(body);
      return Right(register);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    if (sessionId != null) {
      await Future.wait([
        _authenticationRemoteDataSource.deleteSession(sessionId),
        _authenticationLocalDataSource.deleteSessionId(),
      ]);
    }
    print(await _authenticationLocalDataSource.getSessionId());
    return Right(Unit);
  }

  @override
  Future<Either<AppError, List<CarBrandModelResponse>>> getCarBrand() async {
    try {
      final response = await _authenticationRemoteDataSource.getCarBrand();
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CarBrandModelResponse>>> getCarModel(String id) async {
    try {
      final response = await _authenticationRemoteDataSource.getCarModel(id);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, HomeBannerApiResModel>> getHomeBannerData() async {
    try {
      final response = await _authenticationRemoteDataSource.callHomeBannerApi();
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ProfileApiResModel>> getProfile(String userId) async {
    try {
      print('---- user id 3: $userId');
      final response = await _authenticationRemoteDataSource.getProfile(userId);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, TopUpApiResModel>> getTopUp(String userId) async {
    try {
      final response = await _authenticationRemoteDataSource.getTopUp(userId);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, ForgotPassApiResModel>> getForgotPassword(String mobile) async {
    try {
      final response = await _authenticationRemoteDataSource.getForgotPass(mobile);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, FaqApiResModel>> getFaqData() async {
    try {
      final response = await _authenticationRemoteDataSource.getFaq();
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, HomeCardApiResModel>> getHomeCardData(String contentEndpoint) async {
    try {
      final response = await _authenticationRemoteDataSource.callHomeCardApi(contentEndpoint);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, StatusMessageApiResModel>> updateProfile(Map<String, dynamic> body) async {
    try {
      final response = await _authenticationRemoteDataSource.updateProfile(body);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, SubscriptionApiResModel>> getSubscription(String userId) async {
    try {
      final response = await _authenticationRemoteDataSource.doSubscription(userId);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}
