import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:tafeal/core/helpers/shared.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/enums/exception_enums.dart';
import 'error_handling/custom_exception.dart';
import 'error_handling/dio_exception.dart';

class DioHelper {
  Connectivity connectivity = Connectivity();

  static DioHelper? _instance;
  static late Dio _dio;

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
          baseUrl: dotenv.env['base_url']!,
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
            'x-api-key': 'reqres-free-v1',
          },
          validateStatus: (_) => true,
          receiveDataWhenStatusError: true, // Allow any HTTP status code.
          connectTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

      /// Dio Interceptors
      // dio.interceptors.add(TokenInterceptor());

      /// Add a logging interceptor to log HTTP request and response details.
      /// This print the log in terminal strts with: *** Request ***
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );

      /// Add custom interceptors for handling network connectivity and server exceptions.
      // dio.interceptors.add(ConnectivityInterceptor());
      // dio.interceptors.add(ServerExceptionInterceptor());
      // dio.interceptors.add(LoggingInterceptor());

      // Configure HttpClientAdapter for non-web platforms (e.g., mobile).
      if (!kIsWeb) {
        final HttpClient client =
            HttpClient()
              ..badCertificateCallback =
                  (X509Certificate cert, String host, int port) => true;

        // Use the IOHttpClientAdapter for making HTTP requests.
        dio.httpClientAdapter = IOHttpClientAdapter(
          createHttpClient: () => client,
        );
      }
    } on DioException catch (exception) {
      /// Get custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      /// throw custom exception
      throw CustomException(
        errorType,
        'error.png',
        errorMassage: exception.message!,
      );
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.unExcepted,
        'error.png',
        errorMassage: e.toString(),
      );
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
