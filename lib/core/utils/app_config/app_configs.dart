import 'package:clean_arch_demo_las_version/core/constants/enums/environment_typre_enum.dart';
import 'package:clean_arch_demo_las_version/core/constants/enums/flavor_enum.dart';

/// [AppConfig] is a class that contains all the app configurations
class AppConfig {
  static const String devEnv = 'https://dev';
  static const String stagingEnv = 'https://stag';
  FlavorEnum flavor = FlavorEnum.dev;

  // static String domainUrl = 'https://jsonplaceholder.typicode.com';

  /// [currentEnvironment] is the current environment of the app [Staging, Dev]
  static const EnvironmentTypeEnum currentEnvironment = EnvironmentTypeEnum.dev;

  static String getCurrentApiEnvironment() {
    if (currentEnvironment == EnvironmentTypeEnum.staging) {
      return stagingEnv;
    } else if (currentEnvironment == EnvironmentTypeEnum.dev) {
      return devEnv;
    } else {
      return ''; // Another environment.
    }
  }
}
