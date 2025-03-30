import '../../../../core/network/error_handling/custom_error.dart';

abstract class NotificationStates {}

class NotificationStateInit extends NotificationStates {}

class NotificationLoadingState extends NotificationStates {}

class NotificationLoadingMoreDateState extends NotificationStates {}

class NotificationEmptyState extends NotificationStates {}

class NotificationSuccessState extends NotificationStates {}

class NotificationSuccessMoreDateState extends NotificationStates {}

class NotificationErrorMoreDateState extends NotificationStates {
  CustomError? error;

  NotificationErrorMoreDateState({
    this.error,
  });
}

class NotificationErrorState extends NotificationStates {
  CustomError? error;

  NotificationErrorState({
    this.error,
  });
}

class ClearNotificationSuccessState extends NotificationStates {}

class ReadORDeleteNotificationLoadingState extends NotificationStates {
  final int notificationID;

  ReadORDeleteNotificationLoadingState(this.notificationID);
}

class ReadNotificationSuccessState extends NotificationStates {}

class ReadNotificationErrorState extends NotificationStates {
  CustomError? error;

  ReadNotificationErrorState({
    this.error,
  });
}

class DeleteNotificationLoadingState extends NotificationStates {}

class DeleteNotificationSuccessState extends NotificationStates {}

class DeleteNotificationErrorState extends NotificationStates {
  CustomError? error;

  DeleteNotificationErrorState({
    this.error,
  });
}

class EnableOrDisableNotificationLoadingState extends NotificationStates {}

class EnableOrDisableNotificationSuccessState extends NotificationStates {}

class EnableOrDisableNotificationErrorState extends NotificationStates {
  CustomError? error;

  EnableOrDisableNotificationErrorState({
    this.error,
  });
}
