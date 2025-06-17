import 'package:tafeal_demo/features/auth_feature/domain/repository/auth_interface.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth_feature/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../features/auth_feature/data/data_source/local_data_source/auth_local_data_source_impl.dart';
import '../../features/auth_feature/data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../../features/auth_feature/data/data_source/remote_data_source/auth_remote_data_source_impl.dart';
import '../../features/auth_feature/data/repository/auth_repository.dart';
import '../../features/auth_feature/domain/use_cases/auth_use_case.dart';
import '../../features/auth_feature/presentation/logic/splash_cubit/splash_cubit.dart';
import '../../features/language_feature/data/data_source/local_data_source.dart';
import '../../features/language_feature/data/data_source/remote_data_source.dart';
import '../../features/language_feature/data/repository/lang_repository.dart';
import '../../features/language_feature/domain/interface/lang_interface.dart';
import '../../features/language_feature/domain/use_case/lang_use_case.dart';
import '../../features/language_feature/logic/language_cubit/language_cubit.dart';
import '../features/connectivity_feature/data/data_source/remote_data_source.dart';
import '../features/connectivity_feature/data/repository/connectivity_repository.dart';
import '../features/connectivity_feature/domain/interface/connectivity_interface.dart';
import '../features/connectivity_feature/domain/use_case/connectivity_use_case.dart';
import '../features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => LangCubit(sl()));
  sl.registerFactory(() => ConnectivityCubit());
  sl.registerFactory(() => SplashCubit(sl()));

  ///User case
  sl.registerLazySingleton(() => AuthUserCase(repository: sl()));
  sl.registerLazySingleton(() => LangUseCase(sl()));
  sl.registerLazySingleton(() => ConnectivityUseCase(sl()));

  ///repo
  sl.registerLazySingleton<LangInterface>(
    () => LangRepository(
      localDataSourceInterface: sl(),
      remoteDataSourceInterface: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepositoryInterface>(
    () => AuthRepository(
      auhLocalDataSourceInterface: sl(),
      authRemoteDataSourceInterface: sl(),
    ),
  );
  sl.registerLazySingleton<ConnectivityInterface>(
    () => ConnectivityRepository(remoteDataSourceInterface: sl()),
  );

  ///auth local data source interface
  sl.registerLazySingleton<AuthLocalDataSourceInterface>(
    () => AuthLocalDataSourceImp(),
  );
  sl.registerLazySingleton<LanguageLocalDataSourceInterface>(
    () => LanguageLocalDataSourceImp(),
  );

  ///auth remote data source interface
  sl.registerLazySingleton<AuthRemoteDataSourceInterface>(
    () => AuthRemoteDataSourceImp(),
  );
  sl.registerLazySingleton<LanguageRemoteDataSourceInterface>(
    () => LanguageRemoteDataSourceImp(),
  );
  sl.registerLazySingleton<ConnectivityRemoteDataSourceInterface>(
    () => ConnectivityRemoteDataSourceImp(),
  );
}
