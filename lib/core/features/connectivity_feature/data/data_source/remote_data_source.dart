import 'package:dio/dio.dart';

import '../../../../network/dio_helper.dart';

abstract class ConnectivityRemoteDataSourceInterface {
  Future<bool> checkConnection();
}

class ConnectivityRemoteDataSourceImp extends ConnectivityRemoteDataSourceInterface {
  @override
  Future<bool> checkConnection() async {
    try {
      final Response response = await DioHelper.dio.get('https://www.google.com');
      if (response.statusCode == 200) {
        return Future(() => true);
      } else {
        return Future(() => false);
      }
    } catch (e) {
      return Future(() => false);
    }
  }
}
