import 'package:clean_arch_demo_las_version/core/features/socket_feature/data/datasources/socket_data_source.dart';
import 'package:clean_arch_demo_las_version/core/services/socket/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepositoryDataSourceImpl extends SocketRepositoryDataSource {
  @override
  void closeSocket() {
    if (SocketService.instance.socket != null) {
      SocketService.instance.dispose();
    }
  }

  @override
  Socket? getSocket() {
    return SocketService.instance.socket!;
  }

  @override
  Socket? openSocket() {
    if (SocketService.instance.socket?.connected ?? false) {
      SocketService.instance.dispose();
    }
    SocketService.instance.init();
    return SocketService.instance.socket;
  }
}
