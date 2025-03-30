import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TracApiCallsInterceptor extends Interceptor {
  final Dio dio;

  TracApiCallsInterceptor(this.dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('onRequest[${options.method}] => PATH: ${options.path}');
    debugPrint('onRequest Headers: ${options.headers}');
    debugPrint('onRequest Data: ${options.data}');
    return handler.next(options); // continue
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    debugPrint('onResponse[${response.statusCode}] => DATA: ${response.data}');
    return handler.next(response); // continue
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('Error[${err.response?.statusCode}] => MESSAGE: ${err.message}');
    return handler.next(err); //continue
  }
}
