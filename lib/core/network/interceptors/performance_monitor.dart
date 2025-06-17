// import 'package:tafeal/core/constants/app_constants.dart';
// import 'package:tafeal/core/constants/enums/exception_enums.dart';
// import 'package:tafeal/core/helpers/shared.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_performance/firebase_performance.dart';
// import 'package:intl/intl.dart' as intl;
//
// class PerformanceMonitorInterceptor extends Interceptor {
//   final Dio dio;
//   final FirebasePerformance _performance = FirebasePerformance.instance;
//
//   PerformanceMonitorInterceptor(this.dio);
//
//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     /// start the HttpMetric and put it in the request options as extra data to be used in onResponse and onError
//     final traceName = options.uri.normalizePath().toString();
//     devLog('===>>> traceName = $traceName ===>>>');
//     final span = _performance.newHttpMetric(traceName, HttpMethod.Get);
//     span.start().then((value) => devLog('===>>> span.. start() then ===>>>'));
//
//     options.extra['performanceSpan'] = span;
//
//     options.headers['Accept'] = '*/*';
//     if (options.headers['no_timeout'] != 'yes') {
//       options.connectTimeout = const Duration(milliseconds: 30000);
//     }
//
//     options.headers['scope'] =
//         intl.Intl.getCurrentLocale().contains('ar') ? 'ar' : 'en';
//
//     // validation rules.
//     options.validateStatus = (int? status) {
//       return (status ?? 500) < 500;
//     };
//
//     return handler.next(options);
//   }
//
//   @override
//   Future<void> onResponse(
//     Response<dynamic> response,
//     ResponseInterceptorHandler handler,
//   ) async {
//     try {
//       /// stop the HttpMetric
//       final span =
//           response.requestOptions.extra['performanceSpan'] as HttpMetric;
//       span.stop().then((value) => devLog('===>>> span.. stop() then ===>>>'));
//
//       if (response.statusCode == 504) {
//         // showFlutterToast(
//         //   message: 'Server Error',
//         //   bgColor: AppConstants.lightRedColor,
//         //   textColor: AppConstants.lightBlackColor,
//         // );
//       } else if (response.statusCode == 401) {
//         // showFlutterToast(
//         //   message: 'Server Error',
//         //   bgColor: AppConstants.lightRedColor,
//         //   textColor: AppConstants.lightBlackColor,
//         // );
//       }
//     } catch (e) {
//       devLog('===>>> onResponse: $e ===>>>');
//     }
//
//     return handler.next(response);
//   }
//
//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     try {
//       /// stop the HttpMetric
//       final span = err.requestOptions.extra['performanceSpan'] as HttpMetric;
//       span.stop().then(
//         (value) => devLog('===>>> span.. stop() onError then ===>>>'),
//       );
//
//       switch (err.type) {
//         case DioExceptionType.sendTimeout:
//         case DioExceptionType.receiveTimeout:
//           throw err.requestOptions;
//         case DioExceptionType.connectionError:
//           switch (err.response?.statusCode) {
//             case 400:
//               throw CustomStatusCodeErrorType.internet;
//             case 401:
//               throw CustomStatusCodeErrorType.unVerified;
//             case 404:
//               throw CustomStatusCodeErrorType.unVerified;
//             case 409:
//               throw CustomStatusCodeErrorType.gatWay;
//             case 500:
//               throw CustomStatusCodeErrorType.server;
//           }
//           break;
//         case DioExceptionType.cancel:
//           break;
//         case DioExceptionType.unknown:
//           throw CustomStatusCodeErrorType.internet;
//
//         default:
//           throw CustomStatusCodeErrorType.internet;
//       }
//     } catch (e2) {
//       if (e2.toString().contains('No internet connection detected')) {
//         // showFlutterToast(
//         //   message: 'check Internet Connection',
//         //   bgColor: AppConstants.lightRedColor,
//         //   textColor: AppConstants.lightBlackColor,
//         // );
//       }
//     }
//
//     return handler.next(err);
//   }
// }
//
// class PerformanceMonitorInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.extra['startTime'] = DateTime.now();
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     final startTime = response.requestOptions.extra['startTime'] as DateTime;
//     final endTime = DateTime.now();
//     final duration = endTime.difference(startTime).inMilliseconds;
//
//     devLog(
//       '===>>> Request to ${response.requestOptions.uri} took $duration ms ===>>>',
//     );
//
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     final startTime = err.requestOptions.extra['startTime'] as DateTime;
//     final endTime = DateTime.now();
//     final duration = endTime.difference(startTime).inMilliseconds;
//
//     devLog(
//       '===>>> Request to ${err.requestOptions.uri} failed after $duration ms ===>>>',
//     );
//
//     super.onError(err, handler);
//   }
// }
