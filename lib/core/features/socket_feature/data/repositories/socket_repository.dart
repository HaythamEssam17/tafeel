import 'package:clean_arch_demo_las_version/core/features/socket_feature/data/datasources/socket_data_source.dart';
import 'package:clean_arch_demo_las_version/core/features/socket_feature/domain/repositories/socket_repository.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepository implements ISocketRepository {
  final SocketRepositoryDataSource _dataSource;

  SocketRepository({required SocketRepositoryDataSource dataSource})
    : _dataSource = dataSource;

  @override
  void closeSocket() {
    return _dataSource.closeSocket();
  }

  @override
  Socket? getSocket() {
    return _dataSource.getSocket();
  }

  @override
  Socket? openSocket() {
    return _dataSource.openSocket();
  }
}
