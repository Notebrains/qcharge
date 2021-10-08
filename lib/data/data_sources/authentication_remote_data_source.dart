import 'package:qcharge_flutter/data/core/api_constants.dart';
import 'package:qcharge_flutter/data/models/car_brand_api_res_model.dart';
import 'package:qcharge_flutter/data/models/car_brand_model.dart';
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

import '../core/api_client.dart';


abstract class AuthenticationRemoteDataSource {
  Future<LoginApiResModel> doLogin(Map<String, dynamic> requestBody);
  Future<StatusMessageApiResModel> doVerifyUser(Map<String, dynamic> requestBody);
  Future<StatusMessageApiResModel> doSendOtp(Map<String, dynamic> requestBody);
  Future<HomeBannerApiResModel> callHomeBannerApi();
  Future<RegisterApiResModel> doRegister(Map<String, dynamic> requestBody);
  Future<List<CarBrandModelResponse>> getCarBrand();
  Future<List<CarBrandModelResponse>> getCarModel(String id);
  Future<bool> deleteSession(String sessionId);
  Future<ProfileApiResModel> getProfile(String userId);
  Future<TopUpApiResModel> getTopUp(Map<String, dynamic> requestBody);
  Future<ForgotPassApiResModel> getForgotPass(String mobile);
  Future<FaqApiResModel> getFaq();
  Future<HomeCardApiResModel> callHomeCardApi(String contentEndpoint);
  Future<StatusMessageApiResModel> updateProfile(Map<String, dynamic> body);
  Future<SubscriptionApiResModel> doSubscription();
  Future<MapApiResModel> getMapLoc();
  Future<StationDetailsApiResModel> getStationDetails(String stationId);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final ApiClient _client;


  AuthenticationRemoteDataSourceImpl(this._client);


  @override
  Future<LoginApiResModel> doLogin(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      ApiConstants.login,
      params: requestBody,
    );
    print("Login response: $response");
    return LoginApiResModel.fromJson(response);
  }


  @override
  Future<StatusMessageApiResModel> doVerifyUser(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      ApiConstants.verifyMobile,
      params: requestBody,
    );
    print("Verify response: $response");
    return StatusMessageApiResModel.fromJson(response);
  }


  @override
  Future<StatusMessageApiResModel> doSendOtp(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      ApiConstants.sendOtp,
      params: requestBody,
    );
    print("Send Otp response: $response");
    return StatusMessageApiResModel.fromJson(response);
  }


  @override
  Future<RegisterApiResModel> doRegister(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      ApiConstants.register,
      params: requestBody,
    );
    print("Register response: $response");
    return RegisterApiResModel.fromJson(response);
  }

  @override
  Future<bool> deleteSession(String sessionId) async {
    final response = await _client.deleteWithBody(
      'authentication/session',
      params: {
        'session_id': sessionId,
      },
    );
    return response['success'] ?? false;
  }

  @override
  Future<List<CarBrandModelResponse>> getCarBrand() async{
    final response = await _client.post(ApiConstants.carBrand,);
    print('Car brand Res: $response');
    return CarBrandApiResModel.fromJson(response).response!;
  }

  @override
  Future<List<CarBrandModelResponse>> getCarModel(String id) async{
    final response = await _client.post(
        ApiConstants.carModel,
        params: {
          'brand_id': id,
        }
    );
    print('Car model res: $response');
    return CarBrandApiResModel.fromJson(response).response!;
  }

  @override
  Future<HomeBannerApiResModel> callHomeBannerApi() async{
    final response = await _client.post(ApiConstants.cmsHomeBanner,);
    print('Home Banner Api Res: $response');
    return HomeBannerApiResModel.fromJson(response);
  }


  @override
  Future<ProfileApiResModel> getProfile(String userId) async{
    final response = await _client.post(
        ApiConstants.profile,
        params: {
          'user_id': userId,
        }
    );
    print('Profile res: $response');
    return ProfileApiResModel.fromJson(response);
  }

  @override
  Future<TopUpApiResModel> getTopUp(Map<String, dynamic> requestBody) async{
    final response = await _client.post(
        ApiConstants.topUp,
        params: requestBody,
    );
    print('Profile res: $response');
    return TopUpApiResModel.fromJson(response);
  }

  @override
  Future<ForgotPassApiResModel> getForgotPass(String mobile) async {
    final response = await _client.post(
        ApiConstants.forgotPassword,
        params: {
          'mobile': mobile,
        }
    );
    print('Profile res: $response');
    return ForgotPassApiResModel.fromJson(response);
  }

  @override
  Future<FaqApiResModel> getFaq() async {
    final response = await _client.post(ApiConstants.activity,);
    print('Faq Api Res: $response');
    return FaqApiResModel.fromJson(response);
  }

  @override
  Future<HomeCardApiResModel> callHomeCardApi(String contentEndpoint) async {
    final response = await _client.post(contentEndpoint);
    print('Home card api res: $response');
    return HomeCardApiResModel.fromJson(response);
  }

  @override
  Future<StatusMessageApiResModel> updateProfile(Map<String, dynamic> requestBody) async {
    final response = await _client.post(
      ApiConstants.updateProfile,
      params: requestBody,
    );
    print("Update profile response: $response");
    return StatusMessageApiResModel.fromJson(response);
  }

  @override
  Future<SubscriptionApiResModel> doSubscription() async {
    final response = await _client.post(
      ApiConstants.subscription, //change here
      //params: requestBody,
    );
    print("subscription response: $response");
    return SubscriptionApiResModel.fromJson(response);
  }

  @override
  Future<MapApiResModel> getMapLoc() async {
    final response = await _client.post(ApiConstants.mapLoc,);
    print('Map Loc Api Res Model: $response');
    return MapApiResModel.fromJson(response);
  }

  @override
  Future<StationDetailsApiResModel> getStationDetails(String stationId) async {
    final response = await _client.post(
        ApiConstants.mapLocDetails,
        params: {
          'station_id': stationId,
        }
    );
    print('station details res: $response');
    return StationDetailsApiResModel.fromJson(response);
  }


}
