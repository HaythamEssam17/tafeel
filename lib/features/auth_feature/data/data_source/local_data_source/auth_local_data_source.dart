abstract class AuthLocalDataSourceInterface {
  Future<bool> setUserMap(String value);

  Future<bool> setIsLogged(bool value);

  Future<bool> setAccessToken(String value);

  Future<String?> getUserMap();

  Future<bool?> getIsLogged();

  Future<String?> getAccessToken();
}
