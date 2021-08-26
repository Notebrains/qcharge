import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import '../domain/usecases/get_preferred_theme.dart';
import '../domain/usecases/update_theme.dart';
import '../presentation/blocs/theme/theme_cubit.dart';

import '../data/core/api_client.dart';
import '../data/data_sources/authentication_local_data_source.dart';
import '../data/data_sources/authentication_remote_data_source.dart';
import '../data/data_sources/language_local_data_source.dart';
import '../data/repositories/app_repository_impl.dart';
import '../data/repositories/authentication_repository_impl.dart';
import '../domain/repositories/app_repository.dart';
import '../domain/repositories/authentication_repository.dart';
import '../domain/usecases/get_preferred_language.dart';
import '../domain/usecases/login_user.dart';
import '../domain/usecases/logout_user.dart';
import '../domain/usecases/update_language.dart';
import '../presentation/blocs/language/language_cubit.dart';
import '../presentation/blocs/loading/loading_cubit.dart';
import '../presentation/blocs/login/login_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));


  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
          () => LanguageLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
          () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
          () => AuthenticationLocalDataSourceImpl());


  getItInstance.registerLazySingleton<UpdateLanguage>(
          () => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
          () => GetPreferredLanguage(getItInstance()));

  getItInstance
      .registerLazySingleton<UpdateTheme>(() => UpdateTheme(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredTheme>(
          () => GetPreferredTheme(getItInstance()));

  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));

  getItInstance
      .registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));


  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
    getItInstance(),
  ));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
          () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));



  getItInstance.registerSingleton<LanguageCubit>(LanguageCubit(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));

  getItInstance.registerFactory(() => LoginCubit(
    loginUser: getItInstance(),
    logoutUser: getItInstance(),
    loadingCubit: getItInstance(),
  ));

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(
    getPreferredTheme: getItInstance(),
    updateTheme: getItInstance(),
  ));
}
