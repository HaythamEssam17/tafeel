import 'package:tafeal/core/helpers/shared.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants/enums/exception_enums.dart';

class DioExceptions implements Exception {
  late CustomStatusCodeErrorType errorType;
  String errorMassage = "";

  /// custom Exceptions message
  DioExceptions.fromDioError(exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        errorType = CustomStatusCodeErrorType.internet;
        break;
      case DioExceptionType.badResponse:
        errorMassage = exception.response!.data["message"];
        errorType = _handleErrorType(exception.response!.statusCode);
        break;
      case DioExceptionType.badCertificate:
        errorType = CustomStatusCodeErrorType.unVerified;
        break;
      case DioExceptionType.connectionTimeout:
        errorType = CustomStatusCodeErrorType.connectTimeout;
        break;
      case DioExceptionType.unknown:
        devLog("error is ${exception.type} ");
        errorType = CustomStatusCodeErrorType.unExcepted;
        break;
      case DioExceptionType.receiveTimeout:
        errorType = CustomStatusCodeErrorType.receiveTimeout;
        break;
      case DioExceptionType.connectionError:
        errorType = CustomStatusCodeErrorType.server;
        break;
      case DioExceptionType.sendTimeout:
        errorType = CustomStatusCodeErrorType.sendTimeout;
        break;
      default:
        devLog('code ${exception.response!.statusCode}');
        errorType = _handleErrorType(exception.response!.statusCode);
        errorMassage = exception.response!.data["message"];
        break;
    }
  }

  /// custom response statusCode massage
  CustomStatusCodeErrorType _handleErrorType(int statusCode) {
    devLog('CustomStatusCodeErrorType: $statusCode');
    switch (statusCode) {
      case 400:
        return CustomStatusCodeErrorType.badRequest;
      case 401:
        return CustomStatusCodeErrorType.unVerified;
      case 404:
        return CustomStatusCodeErrorType.notFound;
      case 500:
        return CustomStatusCodeErrorType.server;
      case 502:
        return CustomStatusCodeErrorType.badRequest;
      case 302:
        return CustomStatusCodeErrorType.redirection;
      default:
        return CustomStatusCodeErrorType.unExcepted;
    }
  }

  /// [onFlutterError] is the function that will be called when a flutter error is thrown
  static void onFlutterError(FlutterErrorDetails details) {
    devLog(
      'AppExceptionsHandler (onFlutterError): details ==> $details && AppExceptionsHandler.DART',
    );
  }

  @override
  String toString() => '$errorType';
}
