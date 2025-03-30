import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';

abstract class NotificationListRepositoryInterface {
  Future<Either<CustomError, BaseModel>> getNotificationList({required int page});

  Future<Either<CustomError, SuccessModel>> clearAllNotification();

  Future<Either<CustomError, SuccessModel>> markNotificationAsRead({required int notificationId});

  Future<Either<CustomError, SuccessModel>> deleteNotification({required int notificationId});

  Future<Either<CustomError, SuccessModel>> stopOrPauseNotification();
}
