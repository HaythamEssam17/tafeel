import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:clean_arch_demo_las_version/core/network/dio_base_execute.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/keys/api_keys.dart';
import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../../../core/network/error_handling/custom_exception.dart';

abstract class NotificationRemoteDataScoursInterface {
  Future<Either<CustomError, BaseModel>> getNotificationList({required int page});

  Future<Either<CustomError, SuccessModel>> clearAllNotification();

  Future<Either<CustomError, SuccessModel>> stopOrPauseNotification();

  Future<Either<CustomError, SuccessModel>> markNotificationAsRead({required int notificationId});

  Future<Either<CustomError, SuccessModel>> deleteNotification({required int notificationId});
}

class NotificationRemoteDataScoursImpl extends NotificationRemoteDataScoursInterface {
  @override
  Future<Either<CustomError, SuccessModel>> clearAllNotification() async {
    try {
      const String notificationUrl = ApiKeys.clearNotificationKey;

      final FormData data = FormData();

      await DioHelper.instance.postData(url: notificationUrl, data: data);
      return right(SuccessModel());
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, BaseModel>> getNotificationList({required int page}) async {
    return executeAndHandleError(
      () async {
        const String notificationUrl =
            'https://jsonplaceholder.typicode.com/users'; // '${ApiKeys.notificationKey}?page=$page';
        devLog('notificationUrl: $notificationUrl');
        final Response response = await DioHelper.instance.getDate(url: notificationUrl);

        return BaseModel.fromJson(response.data);
      },
    );

    // try {
    //   String notificationUrl = '${ApiKeys.notificationKey}?page=$page';
    //   Response response = await DioHelper.getDate(url: notificationUrl);

    //   return right(BaseModel.fromJson(response.data));
    // } on CustomException catch (ex) {
    //   return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    // }
  }

  @override
  Future<Either<CustomError, SuccessModel>> markNotificationAsRead({required int notificationId}) async {
    try {
      final String notificationUrl = '${ApiKeys.notificationKey}/$notificationId${ApiKeys.readNotificationKey}';
      await DioHelper.instance.postData(url: notificationUrl, data: FormData());

      return right(SuccessModel());
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, SuccessModel>> stopOrPauseNotification() async {
    try {
      const String notificationUrl = ApiKeys.toggleNotificationKey;
      final FormData data = FormData();

      if (!SharedText.currentUser.isNotified!) {
        data.fields.add(MapEntry('token', SharedText.userToken));
      }

      await DioHelper.instance.postData(url: notificationUrl, data: data);

      return right(SuccessModel());
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }

  @override
  Future<Either<CustomError, SuccessModel>> deleteNotification({required int notificationId}) async {
    try {
      final String notificationUrl = '${ApiKeys.notificationKey}/$notificationId${ApiKeys.clearNotificationKey}';
      await DioHelper.instance.deleteData(url: notificationUrl);

      return right(SuccessModel());
    } on CustomException catch (ex) {
      return Left(CustomError(type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath));
    }
  }
}
