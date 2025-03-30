import 'dart:developer' as developer;

import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

/// [SocketService] is a class that contains all socket services.
class SocketService {
  /// [instance] is a [SocketService] that contains information about socket instance.
  static final SocketService instance = SocketService._internal();

  /// [factory SocketService] is a function that return [SocketService] instance.
  factory SocketService() => instance;

  /// [SocketService._internal] is a private constructor for [SocketService] class.
  SocketService._internal() {
    developer.log('socket.instance');
  }

  /// [socket] is a [SocketIO.Socket] that contains information about socket.
  socket_io.Socket? socket;

  /// [currentConversationId] is an integer that contains information about current conversation id.
  int? currentConversationId;

  /// [init] is a function that initialize socket.
  void init() {
    socket = socket_io.io(
      'url here',
      socket_io.OptionBuilder()
          .setTransports(<String>['websocket'])
          .setPath('/ws')
          .setQuery(
            <String, dynamic>{
              'user_id': '1', // Static Value
            },
          )
          .build(),
    );

    Future<void>.delayed(const Duration(seconds: 3), () {
      socket?.emit(
        'login',
        <String, int>{'user_id': 0}, // Static Value
      );
      socket?.emitWithAck(
        'login',
        <String, int>{'user_id': 0}, // Static Value
      );
    });
    devLog('userId: ');
    // socket?.onAny((String event, [dynamic args]) => devLog('socket.on - ${socket?.id} - $event - $args'));
    socket?.on('receive', onReceiveHandler);
    socket?.on('error', errorHandler);

    socket?.connect();
  }

  /// [sendMessage] is a function that send message.
  void sendMessage({required dynamic message}) {
    devLog('socket.sendMessage: $message');
    socket?.emit('send', message);
  }

  /// [onReceiveHandler] is a function that handle receive message.
  void onReceiveHandler(dynamic data) {
    try {
      ///  Handle the logic.
    } catch (e) {
      devLog("Socket error recive $e");
    }
    // try {
    //   final MConversationMessage message = MConversationMessage.fromJson(data);

    //   final MAllConversations? allConversations = UseCasesChat.getAllLocalConversations(NoParam());
    //   allConversations?.updateConversationTime(message.conversationId ?? 0, message.timestamp ?? '');
    //   allConversations?.conversationsMetadata?.updateLastMessage(message.conversationId ?? 0, message.message ?? '');
    //   if (message.senderId != UseCasesAuth.getUserId(NoParam())) {
    //     allConversations?.conversationsMetadata?.updateUnreadMessagesCount(message.conversationId ?? 0);
    //   }

    //   UseCasesChat.setAllConversation(allConversations);
    //   if ((message.conversationId) == UseCasesChat.getActiveConversation(NoParam())?.conversationId) {
    //     UseCasesChat.setConversationMessage(
    //       ParamsSendMessage(
    //         conversationId: message.conversationId ?? 0,
    //         message: message,
    //       ),
    //     );
    //   }
    // } catch (e) {
    //   devLog("Socket error recive $e");
    // }
  }

  /// [errorHandler] is a function that handle socket error.
  void errorHandler(dynamic data) {
    developer.log('socket.errorHandler: $data');
  }

  /// [dispose] is a function that dispose socket.
  void dispose() {
    socket?.dispose();
  }
}
