import '../interface/connectivity_interface.dart';

class ConnectivityUseCase {
  final ConnectivityInterface connectivityInterface;
  ConnectivityUseCase(this.connectivityInterface);

  Future<bool> callCheckConnection() {
    return connectivityInterface.checkConnection();
  }
}
