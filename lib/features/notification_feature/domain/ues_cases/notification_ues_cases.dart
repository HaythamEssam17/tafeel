import 'package:dartz/dartz.dart';

import '../../../../core/model/success_model.dart';
import '../../../../core/network/error_handling/custom_error.dart';
import '../../data/model/notification_model.dart';
import '../repository/notification_interface.dart';

class NotificationUesCases {
  final NotificationListRepositoryInterface repositoryInterface;

  NotificationUesCases(this.repositoryInterface);

  Future<Either<CustomError, List<NotificationModel>>> getListOfNotification({required int page}) {
    return repositoryInterface
        .getNotificationList(page: page)
        .then((value) => value.fold((l) => Left(l), (r) => right(notificationListFromJson(r.data))));
  }

  Future<Either<CustomError, SuccessModel>> clearAllNotification() {
    return repositoryInterface.clearAllNotification();
  }

  Future<Either<CustomError, SuccessModel>> readNotification({required int notificationID}) {
    return repositoryInterface.markNotificationAsRead(notificationId: notificationID);
  }

  Future<Either<CustomError, SuccessModel>> toggleNotificationState() {
    return repositoryInterface.stopOrPauseNotification();
  }

  Future<Either<CustomError, SuccessModel>> deleteNotification({required int notificationID}) {
    return repositoryInterface.deleteNotification(
      notificationId: notificationID,
    );
  }
}
