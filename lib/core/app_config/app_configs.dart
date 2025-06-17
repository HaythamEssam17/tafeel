import '../constants/enums/environment_typre_enum.dart';
import '../constants/enums/flavor_enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// [AppConfig] is a class that contains all the app configurations
class AppConfig {
  static String devEnv = dotenv.env['VAR_NAME'] ?? '';
  static String stagingEnv = dotenv.env['VAR_NAME'] ?? '';
  FlavorEnum flavor = FlavorEnum.dev;

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
