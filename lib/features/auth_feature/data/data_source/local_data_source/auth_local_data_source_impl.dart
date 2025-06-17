import '../../../../../core/constants/keys/local_keys.dart';
import '../../../../../core/data_source/local_source/shared_prefs_imp.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImp extends AuthLocalDataSourceInterface {
  AuthLocalDataSourceImp();

  @override
  Future<bool> setUserMap(String value) async {
    return await SharedPrefs.setString(DbKeys.userMap, value);
  }

  @override
  Future<bool> setIsLogged(bool value) async {
    return await SharedPrefs.setBool(DbKeys.isLogged, value);
  }

  @override
  Future<bool> setAccessToken(String value) async {
    return await SharedPrefs.setString(DbKeys.token, value);
  }

  @override
  Future<String?> getUserMap() async {
    return await SharedPrefs.getString(DbKeys.userMap);
  }

  @override
  Future<bool?> getIsLogged() async {
    return await SharedPrefs.getBool(DbKeys.isLogged);
  }

  @override
  Future<String?> getAccessToken() async {
    return await SharedPrefs.getString(DbKeys.token);
  }
}
