import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/notification_model.dart';
import '../../domain/ues_cases/notification_ues_cases.dart';
import 'notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit(this._repo) : super(NotificationStateInit());

  static NotificationCubit get(BuildContext context) => BlocProvider.of(context);

  final NotificationUesCases _repo;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<NotificationModel> notificationList = [];
  bool hasMoreData = false;

  Future onRefresh() async {
    getNotificationList();
  }

  void setupScrollController() {
    if (scrollController.offset > scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! NotificationLoadingMoreDateState && hasMoreData) {
        whenScrollNotificationPagination();
      }
    }
  }

  /// Pagination Function
  void whenScrollNotificationPagination() async {
    emit(NotificationLoadingMoreDateState());

    page = page + 1;
    final result = await _repo.getListOfNotification(page: page);
    result.fold((error) => emit(NotificationErrorMoreDateState(error: error)), (notificationListData) {
      final tempList = notificationListData;
      hasMoreData = tempList.length == 10;
      notificationList.addAll(tempList);
      emit(NotificationSuccessMoreDateState());
    });
  }

  /// Get All notification List
  void getNotificationList() async {
    emit(NotificationLoadingState());
    page = 1;
    final result = await _repo.getListOfNotification(page: page);
    result.fold((error) => emit(NotificationErrorState(error: error)), (notificationListData) {
      notificationList = notificationListData;
      hasMoreData = notificationList.length == 10;
      if (notificationList.isEmpty) {
        emit(NotificationEmptyState());
      } else {
        emit(NotificationSuccessState());
      }
    });
  }

  /// clear All notification List
  void clearAllNotificationList() async {
    emit(NotificationLoadingState());
    final result = await _repo.clearAllNotification();
    result.fold(
        (error) => emit(NotificationErrorState(
              error: error,
            )),
        (r) => emit(ClearNotificationSuccessState()));
  }

  /// delete notification
  void deleteNotificationList({required int notificationId}) async {
    emit(ReadORDeleteNotificationLoadingState(notificationId));
    final result = await _repo.deleteNotification(notificationID: notificationId);
    result.fold(
        (error) => emit(DeleteNotificationErrorState(
              error: error,
            )), (r) {
      notificationList.removeWhere((element) => element.id == notificationId);
      emit(DeleteNotificationSuccessState());
    });
  }

  /// mark notification as read
  void readNotification({required int notificationId}) async {
    emit(ReadORDeleteNotificationLoadingState(notificationId));
    final result = await _repo.readNotification(notificationID: notificationId);
    result.fold(
        (error) => emit(ReadNotificationErrorState(
              error: error,
            )), (r) {
      for (var element in notificationList) {
        if (element.id == notificationId) {
          element.isRead = true;
        }
      }
      emit(ReadNotificationSuccessState());
    });
  }

  bool isNotified = false;

  ///Enable or disable notification
  void enableOrDisableNotification() async {
    emit(EnableOrDisableNotificationLoadingState());
    final result = await _repo.toggleNotificationState();
    result.fold((error) => emit(EnableOrDisableNotificationErrorState(error: error)), (r) {
      isNotified = !isNotified;
      SharedText.currentUser.isNotified = isNotified;

      emit(EnableOrDisableNotificationSuccessState());
    });
  }
}
