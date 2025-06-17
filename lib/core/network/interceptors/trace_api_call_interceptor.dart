import 'package:dio/dio.dart';

class TracApiCallsInterceptor extends Interceptor {
  final Dio dio;

  TracApiCallsInterceptor(this.dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('onRequest[${options.method}] => PATH: ${options.path}');
    print('onRequest Headers: ${options.headers}');
    print('onRequest Data: ${options.data}');
    return handler.next(options); // continue
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('onResponse[${response.statusCode}] => DATA: ${response.data}');
    return handler.next(response); // continue
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    print('Error[${err.response?.statusCode}] => MESSAGE: ${err.message}');
    return handler.next(err); //continue
  }
}
