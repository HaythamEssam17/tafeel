import 'dart:async';

import 'package:tafeal/core/helpers/shared.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final Dio dio;
  final Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  RetryOnConnectionChangeInterceptor({
    required this.dio,
    required this.connectivity,
  }) {
    // Listen for connectivity changes
    connectivitySubscription = connectivity.onConnectivityChanged.listen((
      ConnectivityResult result,
    ) {
      if (result == ConnectivityResult.none) {
        devLog('===>>> Interceptor Internet Disconnected ===>>>');
      } else {
        devLog('===>>> Interceptor Internet Connected ===>>>');
      }
    });
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldRetry(err)) {
      try {
        await _waitForConnection();
        // Retry the request
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        // Return the original error if retry fails
        handler.next(err);
      }
    } else {
      // Pass the error further if it should not be retried
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    // Check if the error is due to connection issues
    return err.type == DioExceptionType.connectionError;
  }

  Future<void> _waitForConnection() async {
    final Completer<void> completer = Completer<void>();

    connectivitySubscription.onData((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        completer.complete();
      }
    });

    return completer.future;
  }

  Future<Response> _retry(RequestOptions requestOptions) {
    // Clone the original request and retry
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      extra: requestOptions.extra,
      followRedirects: requestOptions.followRedirects,
      listFormat: requestOptions.listFormat,
      maxRedirects: requestOptions.maxRedirects,
      receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
      receiveTimeout: requestOptions.receiveTimeout,
      requestEncoder: requestOptions.requestEncoder,
      responseDecoder: requestOptions.responseDecoder,
      sendTimeout: requestOptions.sendTimeout,
      validateStatus: requestOptions.validateStatus,
    );

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
      cancelToken: requestOptions.cancelToken,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
    );
  }

  void dispose() {
    // Cancel the subscription when the interceptor is disposed
    connectivitySubscription.cancel();
  }
}
