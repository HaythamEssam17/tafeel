import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/app/my_app.dart';
import 'core/app_config/injection_container.dart' as di;
import 'core/constants/app_colors.dart';
import 'core/data_source/local_source/shared_prefs_imp.dart';
import 'core/helpers/observers/bloc_observer.dart';
import 'core/helpers/shared.dart';
import 'core/model/app_security_model.dart';
import 'core/network/dio_helper.dart';
import 'core/network/error_handling/dio_exception.dart';

void main() async {
  final WidgetsBinding bind = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: bind);

  FlutterNativeSplash.remove();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: AppColors.mainColor),
  );

  FlutterError.onError = DioExceptions.onFlutterError;

  /// This function is to check the security of the app.
  /*
    [ParamsAppCheck] is a model contains the params we have to check,
    Params default values are equals to false
  */
  checkAppSecurity(
    paramsAppCheck: AppSecurityModel(
      isEmulated: true,
      canMockLocation: true,
      onExternalStorage: true,
      isRooted: true,
      onDevMode: true,
    ),
  );

  /// Initialize .Env Enviroment to load the file.
  await dotenv.load(fileName: ".env");

  /// Initialize Flutter_Downloader
  // await FlutterDownloader.initialize(debug: true);

  /// Initialize local storage
  await SharedPrefs.init();

  /// Initialize the Injections
  await di.init();

  DioHelper.instance;

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
