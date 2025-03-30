import 'package:socket_io_client/socket_io_client.dart' as socket_io;

abstract class SocketRepositoryDataSource {
  socket_io.Socket? openSocket();

  void closeSocket();

  socket_io.Socket? getSocket();
}
