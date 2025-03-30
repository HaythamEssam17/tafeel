import 'package:dartz/dartz.dart';

import '../../../../core/model/base_model.dart';
import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../domain/repository/notification_interface.dart';
import '../data_source/remote_data_source.dart';

class NotificationListRepository extends NotificationListRepositoryInterface {
  final NotificationRemoteDataScoursInterface remoteDataScoursInterface;

  NotificationListRepository(
    this.remoteDataScoursInterface,
  );

  @override
  Future<Either<CustomError, SuccessModel>> clearAllNotification() {
    return remoteDataScoursInterface.clearAllNotification();
  }

  @override
  Future<Either<CustomError, BaseModel>> getNotificationList({required int page}) {
    return remoteDataScoursInterface.getNotificationList(page: page);
  }

  @override
  Future<Either<CustomError, SuccessModel>> markNotificationAsRead({required int notificationId}) {
    return remoteDataScoursInterface.markNotificationAsRead(notificationId: notificationId);
  }

  @override
  Future<Either<CustomError, SuccessModel>> stopOrPauseNotification() {
    return remoteDataScoursInterface.stopOrPauseNotification().then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }

  @override
  Future<Either<CustomError, SuccessModel>> deleteNotification({required int notificationId}) {
    return remoteDataScoursInterface.deleteNotification(notificationId: notificationId);
  }
}
