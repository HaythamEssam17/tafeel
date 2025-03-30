import 'package:clean_arch_demo_las_version/core/features/socket_feature/domain/repositories/socket_repository.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketUseCases {
  final ISocketRepository _iSocketRepository;

  SocketUseCases({required ISocketRepository iSocketRepository}) : _iSocketRepository = iSocketRepository;

  void closeSocket() {
    return _iSocketRepository.closeSocket();
  }

  Socket? getSocket() {
    return _iSocketRepository.getSocket();
  }

  Socket? openSocket() {
    return _iSocketRepository.openSocket();
  }
}
