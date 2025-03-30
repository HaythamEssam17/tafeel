import '../../../../core/constants/keys/local_keys.dart';
import '../../../../core/data_source/local_source/shared_prefs_imp.dart';

abstract class SettingLocalDataSourceInterface {
  Future<bool> setSettingMap({required String settingMap});

  Future<String?> getSettingMap();
}

class SettingLocalDataSourceImp extends SettingLocalDataSourceInterface {

  @override
  Future<String?> getSettingMap() async {
    return await SharedPrefs.getString(DbKeys.settingKey);
  }

  @override
  Future<bool> setSettingMap({required String settingMap}) async {
    return await SharedPrefs.setString(DbKeys.settingKey, settingMap);
  }
}
