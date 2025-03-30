import '../../features/auth_feature/data/model/auth_base_model.dart';
import 'responsive_ui/device_info.dart';

class SharedText {
  static final SharedText _singleton = SharedText._internal();

  factory SharedText() {
    return _singleton;
  }

  SharedText._internal();

  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  static double designWidth = 375.0;
  static double designHeight = 812.0;

  static DeviceInfo? deviceType;

  static AuthBaseModel currentUser = AuthBaseModel();

  static String currentLocale = 'ar';
  static String userToken = '';
  static String deviceToken = '';

  /// On_Will_Pop app close time
  static DateTime? currentBackPressTime;

  static bool isARLocal() => currentLocale == 'ar';
}
