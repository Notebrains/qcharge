import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:qcharge_flutter/domain/usecases/add_update_car_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/delete_car_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/faq_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/forgot_pass_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/get_car_brand.dart';
import 'package:qcharge_flutter/domain/usecases/get_car_model.dart';
import 'package:qcharge_flutter/domain/usecases/home_banner.dart';
import 'package:qcharge_flutter/domain/usecases/home_card_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/map_station_details_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/map_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/profile_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/register_user.dart';
import 'package:qcharge_flutter/domain/usecases/send_otp.dart';
import 'package:qcharge_flutter/domain/usecases/subscription_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/topup_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/update_profile_usecase.dart';
import 'package:qcharge_flutter/domain/usecases/verify_user.dart';
import 'package:qcharge_flutter/presentation/blocs/contents/faq_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/add_update_car_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/delete_car_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/home_banner_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/home_card_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/map_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/map_station_details_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/profile_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/subscription_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/topup_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/update_profile_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/login/forgot_pass_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_model_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/register_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/verify/req_otp_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/verify/verify_cubit.dart';

import '../data/core/api_client.dart';
import '../data/data_sources/authentication_local_data_source.dart';
import '../data/data_sources/authentication_remote_data_source.dart';
import '../data/data_sources/language_local_data_source.dart';
import '../data/repositories/app_repository_impl.dart';
import '../data/repositories/authentication_repository_impl.dart';
import '../domain/repositories/app_repository.dart';
import '../domain/repositories/authentication_repository.dart';
import '../domain/usecases/get_preferred_language.dart';
import '../domain/usecases/get_preferred_theme.dart';
import '../domain/usecases/login_user.dart';
import '../domain/usecases/logout_user.dart';
import '../domain/usecases/update_language.dart';
import '../domain/usecases/update_theme.dart';
import '../presentation/blocs/language/language_cubit.dart';
import '../presentation/blocs/loading/loading_cubit.dart';
import '../presentation/blocs/login/login_cubit.dart';
import '../presentation/blocs/register/car_brand_cubit.dart';
import '../presentation/blocs/theme/theme_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(() => AuthenticationLocalDataSourceImpl());

  getItInstance.registerLazySingleton<UpdateLanguage>(() => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(() => GetPreferredLanguage(getItInstance()));

  getItInstance.registerLazySingleton<UpdateTheme>(() => UpdateTheme(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredTheme>(() => GetPreferredTheme(getItInstance()));

  getItInstance.registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));

  getItInstance.registerLazySingleton<ForgotPassword>(() => ForgotPassword(getItInstance()));

  getItInstance.registerLazySingleton<ForgotPasswordCubit>(() => ForgotPasswordCubit(forgotPassword: getItInstance()));

  getItInstance.registerLazySingleton<RegisterUser>(() => RegisterUser(getItInstance()));
  getItInstance.registerLazySingleton<VerifyUser>(() => VerifyUser(getItInstance()));
  getItInstance.registerLazySingleton<SendOtp>(() => SendOtp(getItInstance()));

  getItInstance.registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));

  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
        getItInstance(),
      ));

  getItInstance.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerSingleton<LanguageCubit>(LanguageCubit(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));

  getItInstance.registerFactory(() => LoginCubit(
        loginUser: getItInstance(),
        logoutUser: getItInstance(),
        loadingCubit: getItInstance(),
      ));

  getItInstance.registerFactory(() => RegisterCubit(
        registerUser: getItInstance(),
        loadingCubit: getItInstance(),
      ));

  getItInstance.registerFactory(() => ReqOtpCubit(
        sendOtp: getItInstance(),
        loadingCubit: getItInstance(),
      ));

  getItInstance.registerFactory(() => VerifyCubit(
        verifyUser: getItInstance(),
        loadingCubit: getItInstance(),
      ));

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());

  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(
    getPreferredTheme: getItInstance(),
    updateTheme: getItInstance(),
  ));

  getItInstance.registerLazySingleton<CarBrand>(() => CarBrand(getItInstance()));

  getItInstance.registerFactory(
    () => CarBrandCubit(
      loadingCubit: getItInstance(),
      carBrand: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<CarModel>(() => CarModel(getItInstance()));

  getItInstance.registerFactory(
    () => CarModelCubit(
      loadingCubit: getItInstance(),
      carModel: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<ProfileCubit>(() => ProfileCubit(profile: getItInstance()));

  getItInstance.registerLazySingleton<Profile>(() => Profile(getItInstance()));

  getItInstance.registerLazySingleton<TopUp>(() => TopUp(getItInstance()));

  getItInstance.registerLazySingleton<HomeBanner>(() => HomeBanner(getItInstance()));

  getItInstance.registerLazySingleton<HomeCard>(() => HomeCard(getItInstance()));

  getItInstance.registerLazySingleton<TopUpCubit>(() => TopUpCubit(topUp: getItInstance()));

  getItInstance.registerLazySingleton<MapUsecase>(() => MapUsecase(getItInstance()));

  getItInstance.registerLazySingleton<MapStationDetailsUsecase>(() => MapStationDetailsUsecase(getItInstance()));

  getItInstance.registerLazySingleton<MapCubit>(() => MapCubit(mapUsecase: getItInstance()));

  getItInstance.registerLazySingleton<MapStationDetailsCubit>(
    () => MapStationDetailsCubit(mapStationDetailsUsecase: getItInstance()),
  );

  getItInstance.registerFactory(
    () => HomeCardCubit(
      loadingCubit: getItInstance(),
      homeCard: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => HomeBannerCubit(
      homeBanner: getItInstance(),
      profileCubit: getItInstance(),
      loadingCubit: getItInstance(),
      topUpCubit: getItInstance(),
      mapCubit: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<FaqUsecase>(() => FaqUsecase(getItInstance()));

  getItInstance.registerFactory(
    () => FaqCubit(
      loadingCubit: getItInstance(),
      faq: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<UpdateProfileUser>(() => UpdateProfileUser(getItInstance()));

  getItInstance.registerFactory(
    () => UpdateProfileCubit(
      loadingCubit: getItInstance(),
      updateProfileUser: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<Subscription>(() => Subscription(getItInstance()));

  getItInstance.registerFactory(
    () => SubscriptionCubit(
      loadingCubit: getItInstance(),
      subscriptionUser: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<DeleteCarUsecase>(() => DeleteCarUsecase(getItInstance()));

  getItInstance.registerFactory(
    () => DeleteCarCubit(
      deleteCarUsecase: getItInstance(),
      loadingCubit: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<AddUpdateCarUsecase>(() => AddUpdateCarUsecase(getItInstance()));

  getItInstance.registerFactory(
    () => AddUpdateCarCubit(
      addUpdateCarUsecase: getItInstance(),
      loadingCubit: getItInstance(),
    ),
  );
}
