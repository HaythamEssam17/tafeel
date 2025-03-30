import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/data/data_source/remote_data_source.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/data/repository/connectivity_repository.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/domain/interface/connectivity_interface.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/domain/use_case/connectivity_use_case.dart';
import 'package:clean_arch_demo_las_version/core/features/connectivity_feature/presentation/logic/connectivity_cubit/connectivity_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/data/datasources/download_data_source.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/data/datasources/download_data_source_impl.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/data/repositories/download_repository.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/domain/repositories/download_interfaces.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/domain/usecases/get_downloads_use_cases/get_downoads_use_case.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/download_feature_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/download_feature/presentation/cubit/get_downloads_feature/get_downloads_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/presentation/cubit/dynamic_form_feature_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/logic/horizontal_stepper_cubit.dart';
import 'package:clean_arch_demo_las_version/core/presentation/logic/search_filter_cubit/search_filter_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/data/data_source/auth_local_data_source.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/data/data_source/otp_remote_data_source.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/data/data_source/password_remote_data_source.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/data/repository/auth_repository.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/data/repository/otp_repository.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/data/repository/password_repository.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/repository/auth_interface.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/repository/otp_interface.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/repository/password_interface.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/use_cases/auth_use_case.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/use_cases/forget_password_user_case.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/domain/use_cases/otp_ues_cases.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/login_cubit/login_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/otp_cubit/otp_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/password_cubit/password_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:clean_arch_demo_las_version/features/auth_feature/presentation/logic/splash_cubit/splash_cubit.dart';
import 'package:clean_arch_demo_las_version/features/help_feature/Data/data_source/remote_data_source.dart';
import 'package:clean_arch_demo_las_version/features/help_feature/Data/repository/help_repository.dart';
import 'package:clean_arch_demo_las_version/features/help_feature/Domain/repository/help_interface.dart';
import 'package:clean_arch_demo_las_version/features/help_feature/Domain/ues_cases/help_ues_cases.dart';
import 'package:clean_arch_demo_las_version/features/help_feature/presentation/logic/help_cubit/help_cubit.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/data/data_source/local_data_source.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/data/data_source/remote_data_source.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/data/repository/lang_repository.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/domain/interface/lang_interface.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/domain/use_case/lang_use_case.dart';
import 'package:clean_arch_demo_las_version/features/language_feature/logic/language_cubit/language_cubit.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/data/data_sources/local_data_sources.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/data/data_sources/remote_data_sources.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/data/repository/setting_repository.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/domain/repository/setting_interface.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/domain/ues_cases/setting_ues_cases.dart';
import 'package:clean_arch_demo_las_version/features/setting_feature/logic/setting_cubit/setting_cubit.dart';
import 'package:clean_arch_demo_las_version/features/terms_and_conditions_feature/data/data_source/remote_data_source.dart';
import 'package:clean_arch_demo_las_version/features/terms_and_conditions_feature/data/repository/terms_and_conditions_repository.dart';
import 'package:clean_arch_demo_las_version/features/terms_and_conditions_feature/domain/repository/terms_and_conditions_interface.dart';
import 'package:clean_arch_demo_las_version/features/terms_and_conditions_feature/domain/ues_cases/terms_and_conditions_ues_cases.dart';
import 'package:clean_arch_demo_las_version/features/terms_and_conditions_feature/presentation/logic/terms_and_condition_cubit/terms_and_condition_cubit.dart';
import 'package:get_it/get_it.dart';

import '/features/auth_feature/data/data_source/phone_data_source.dart';
import '/features/auth_feature/data/repository/phone_repository.dart';
import '/features/auth_feature/domain/repository/phone_interface.dart';
import '/features/auth_feature/domain/use_cases/phone_use_case.dart';
import '/features/auth_feature/presentation/logic/phone_cubit/phone_cubit.dart';
import '/features/notification_feature/data/data_source/remote_data_source.dart';
import '/features/notification_feature/data/repository/notification_repository.dart';
import '/features/notification_feature/domain/repository/notification_interface.dart';
import '/features/notification_feature/domain/ues_cases/notification_ues_cases.dart';
import '/features/notification_feature/presentation/logic/notification_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => SignUpCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => PasswordCubit(sl()));
  sl.registerFactory(() => SettingCubit(sl()));
  sl.registerFactory(() => LangCubit(sl()));
  sl.registerFactory(() => ConnectivityCubit());
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerFactory(() => NotificationCubit(sl()));
  sl.registerFactory(() => PhoneCubit(sl()));
  sl.registerFactory(() => AllFilterCubit());
  sl.registerFactory(() => TermsAndConditionsCubit(sl()));
  sl.registerFactory(() => HelpCubit(sl()));
  sl.registerFactory(() => DownloadFeatureCubit());
  sl.registerFactory(() => GetDownloadsCubit(sl()));
  sl.registerFactory(() => HorizontalStepperCubit());
  sl.registerFactory(() => DynamicFormFeatureCubit());

  ///User case
  sl.registerLazySingleton(() => AuthUserCase(repository: sl()));
  sl.registerLazySingleton(() => PasswordUesCases(sl(), sl()));
  sl.registerLazySingleton(() => OtpUsesCases(sl()));
  sl.registerLazySingleton(() => SettingUserCase(repository: sl()));
  sl.registerLazySingleton(() => LangUseCase(sl()));
  sl.registerLazySingleton(() => ConnectivityUseCase(sl()));
  sl.registerLazySingleton(() => PhoneUseCase(sl()));
  sl.registerLazySingleton(() => NotificationUesCases(sl()));
  sl.registerLazySingleton(() => TermsAndConditionsUesCases(sl()));
  sl.registerLazySingleton(() => HelpUsesCases(sl()));
  sl.registerLazySingleton(() => GetDownloadsUseCase(sl()));

  ///repo
  sl.registerLazySingleton<OtpRepositoryInterface>(() => OtpRepository(sl(), sl()));
  sl.registerLazySingleton<PasswordRepositoryInterface>(() => PasswordRepository(sl(), sl()));
  sl.registerLazySingleton<AuthRepositoryInterface>(
      () => AuthRepository(auhLocalDataSourceInterface: sl(), authRemoteDataSourceInterface: sl()));
  sl.registerLazySingleton<SettingRepositoryInterface>(() => SettingRepository(sl(), sl()));
  sl.registerLazySingleton<LangInterface>(
      () => LangRepository(localDataSourceInterface: sl(), remoteDataSourceInterface: sl()));
  sl.registerLazySingleton<ConnectivityInterface>(() => ConnectivityRepository(remoteDataSourceInterface: sl()));
  () => SettingRepository(sl(), sl());
  sl.registerLazySingleton<NotificationListRepositoryInterface>(() => NotificationListRepository(sl()));
  sl.registerLazySingleton<PhoneInterface>(() => PhoneRepository(sl()));
  sl.registerLazySingleton<TermsAndConditionsRepositoryInterface>(() => TermsAndConditionsListRepository(sl()));
  sl.registerLazySingleton<HelpInterface>(() => HelpRepository(sl()));
  sl.registerLazySingleton<IDownloadInterfaces>(() => DownloadRepository(sl()));

  ///auth local data source interface
  sl.registerLazySingleton<AuthLocalDataSourceInterface>(() => AuthLocalDataSourceImp());
  sl.registerLazySingleton<SettingLocalDataSourceInterface>(() => SettingLocalDataSourceImp());
  sl.registerLazySingleton<LanguageLocalDataSourceInterface>(() => LanguageLocalDataSourceImp());
  () => SettingLocalDataSourceImp();

  ///auth remote data source interface
  sl.registerLazySingleton<AuthRemoteDataSourceInterface>(() => AuthRemoteDataSourceImp());
  sl.registerLazySingleton<OtpRemoteDataSourceInterface>(() => OtpRemoteDataSourceImp());
  sl.registerLazySingleton<PasswordRemoteDataSourceInterface>(() => PasswordRemoteDataSourceImpl());
  sl.registerLazySingleton<SettingRemoteDataSourceInterface>(() => SettingRemoteDataSourceImpl());
  sl.registerLazySingleton<LanguageRemoteDataSourceInterface>(() => LanguageRemoteDataSourceImp());
  sl.registerLazySingleton<ConnectivityRemoteDataSourceInterface>(() => ConnectivityRemoteDataSourceImp());
  sl.registerLazySingleton<NotificationRemoteDataScoursInterface>(() => NotificationRemoteDataScoursImpl());
  sl.registerLazySingleton<PhoneDataSource>(() => PhoneDataSourceImpl());
  sl.registerLazySingleton<TermsRemoteDataScoursInterface>(() => TermsRemoteDataScoursImpl());
  sl.registerLazySingleton<HelpRemoteDataScoursInterface>(() => HelpRemoteDataScoursImp());
  sl.registerLazySingleton<DownloadDataSource>(() => DownloadDataSourceImpl());
}
