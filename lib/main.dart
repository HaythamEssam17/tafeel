import 'package:clean_arch_demo_las_version/core/app/my_app.dart';
import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/data_source/local_source/shared_prefs_imp.dart';
import 'package:clean_arch_demo_las_version/core/helpers/observers/bloc_observer.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/model/app_security_model.dart';
import 'package:clean_arch_demo_las_version/core/network/dio_helper.dart';
import 'package:clean_arch_demo_las_version/core/network/error_handling/dio_exception.dart';
import 'package:clean_arch_demo_las_version/core/services/firebase/firebase_services.dart';
import 'package:clean_arch_demo_las_version/core/utils/app_config/injection_container.dart'
    as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final WidgetsBinding bind = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bind);

  await Future.delayed(Duration(seconds: 2));

  FlutterNativeSplash.remove();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: AppConstants.mainColor),
  );

  FlutterError.onError = DioExceptions.onFlutterError;

  await FirebaseService.instance.initializeFirebase();

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

  /// Initialize .Env Environment to load the file.
  await dotenv.load(fileName: ".env");

  /// Initialize Flutter_Downloader
  await FlutterDownloader.initialize(debug: true);

  /// Initialize local storage
  await SharedPrefs.init();

  /// Initialize the Injections
  await di.init();

  /// Initialize Dio SIngleton Instance
  DioHelper.instance;

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
