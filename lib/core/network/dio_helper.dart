import 'dart:convert';

import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/network/interceptors/connectivity_retry_interceptor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/enums/exception_enums.dart';
import '../utils/app_config/app_configs.dart';
import 'error_handling/custom_exception.dart';
import 'error_handling/dio_exception.dart';
import 'interceptors/performance_monitor.dart';
import 'interceptors/trace_api_call_interceptor.dart';

class DioHelper {
  static DioHelper? _instance;
  static late Dio _dio;
  Connectivity connectivity = Connectivity();

  static Dio get dio => _dio;

  // Instantiate the class if it hasn't been created yet.
  static DioHelper get instance {
    devLog('Dio singleton instance --->');
    _instance ??= DioHelper._();
    return _instance!;
  }

  // Initialize Dio with default options
  DioHelper._() {
    try {
      _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.getCurrentApiEnvironment(),
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
          receiveDataWhenStatusError: true,
        ),
      );

      /// Dio Interceptors
      dio.interceptors.addAll([
        PerformanceMonitorInterceptor(dio),
        PerformanceMonitorInterceptors(),
        TracApiCallsInterceptor(dio),
        RetryOnConnectionChangeInterceptor(
          dio: dio,
          connectivity: connectivity,
        ),
      ]);
    } on DioException catch (exception) {
      /// Get custom massage for the exception
      final errorMessage = DioExceptions.fromDioError(exception).errorType;

      /// throw custom exception
      throw CustomException(errorMessage, 'errfinalor.png');
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  ///use this method to get data from api
  Future<Response> getDate({required String url}) async {
    try {
      devLog('dio hearders: ${dio.options.headers}');
      return await dio.get(url);
    } on DioException catch (exception) {
      /// Get custom massage for the exception
      devLog(
        "here is the error from dio get data ${exception.response?.data["message"]} ",
      );
      devLog("here is the error from dio get data ${exception.message ?? ''} ");
      final CustomStatusCodeErrorType errorType =
          DioExceptions.fromDioError(exception).errorType;
      String errorMessage = '';
      if (DioExceptions.fromDioError(exception).errorMassage.isEmpty) {
        errorMessage = exception.response?.data["message"] ?? exception.message;
      } else {
        errorMessage = DioExceptions.fromDioError(exception).errorMassage;
      }

      /// throw custom exception
      throw CustomException(errorType, 'error.png', errorMassage: errorMessage);
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  ///use this method to send data to api
  Future<Response> postData({
    required String url,
    required FormData data,
  }) async {
    try {
      devLog('user token: ${dio.options.headers}');
      final response = await dio.post(url, data: data);

      devLog(response.statusCode.toString());
      devLog(response.statusMessage ?? 'sttaus messgae');

      return response;
    } on DioException catch (exception) {
      devLog(
        "here is the error from dio post data ${exception.response?.data["message"]} ",
      );

      /// G1et custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, 'error.png', errorMassage: errorMessage);
    } catch (error) {
      devLog("this is error from CustomException exception$error");
      devLog(
        "this is error from CustomException exception${error.runtimeType}",
      );

      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  ///use this method to update data in api
  Future<Response> putData({
    required String url,
    required FormData data,
  }) async {
    try {
      final response = await dio.put(url, data: data);
      devLog(response.statusCode.toString());
      devLog(response.statusMessage ?? 'status message');

      return response;
    } on DioException catch (exception) {
      devLog(
        "here is the error from dio put data ${exception.response?.data["message"]} ",
      );

      /// G1et custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, 'error.png', errorMassage: errorMessage);
    } catch (error) {
      devLog("this is error from CustomException exception$error");
      devLog(
        "this is error from CustomException exception${error.runtimeType}",
      );

      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  ///use this method to delete data in api
  Future<Response> deleteData({required String url}) async {
    try {
      final response = await dio.delete(url);
      devLog(response.statusCode.toString());
      devLog(response.statusMessage ?? 'status message');

      return response;
    } on DioException catch (exception) {
      devLog(
        "here is the error from dio put data ${exception.response?.data["message"]} ",
      );

      /// G1et custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;
      if (DioExceptions.fromDioError(exception).errorType !=
          CustomStatusCodeErrorType.unVerified) {}

      /// throw custom exception
      throw CustomException(errorType, 'error.png', errorMassage: errorMessage);
    } catch (error) {
      devLog("this is error from CustomException exception$error");
      devLog(
        "this is error from CustomException exception${error.runtimeType}",
      );

      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  /// [SlackHelper] Send a Slack Message When Any Error Happens
  Future sendMessageToSlack(String messageText) async {
    try {
      final request = {'text': messageText};

      /// Send to SLack Webhook
      dio
          .post(
            dotenv.env['slack_webHock_url'] ?? '',
            data: json.encode(request),
          )
          .then((response) {
            devLog('Slack webhook response: --- ${response.data}');
          });
    } catch (e) {
      devLog('Slack webhook exception --- Error --- $e');

      return null;
    }
  }
}
