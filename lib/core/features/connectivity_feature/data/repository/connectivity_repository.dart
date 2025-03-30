import '../../domain/interface/connectivity_interface.dart';
import '../data_source/remote_data_source.dart';

class ConnectivityRepository extends ConnectivityInterface {
  final ConnectivityRemoteDataSourceInterface remoteDataSourceInterface;

  ConnectivityRepository(
      {required this.remoteDataSourceInterface});

  @override
  Future<bool> checkConnection() {
    return remoteDataSourceInterface.checkConnection();
  }


}
