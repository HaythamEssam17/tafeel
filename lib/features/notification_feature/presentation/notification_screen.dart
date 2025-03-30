import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/shared.dart';
import '../../../core/presentation/widgets/Alert_Dialogs/custom_snack_bar.dart';
import '../../../core/presentation/widgets/common_app_bar_widget.dart';
import '../../../core/presentation/widgets/common_empty_widget.dart';
import '../../../core/presentation/widgets/common_error_widget.dart';
import '../../../core/presentation/widgets/common_loading_widget.dart';
import '../../../core/presentation/widgets/common_title_text.dart';
import '../../../core/presentation/widgets/loading_widgets/list_loader_widget.dart';
import 'logic/notification_cubit.dart';
import 'logic/notification_states.dart';
import 'notification_item.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  late NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();
    notificationCubit = NotificationCubit.get(context);
    notificationCubit.getNotificationList();
    notificationCubit.scrollController = ScrollController();
    notificationCubit.scrollController.addListener(() {
      notificationCubit.setupScrollController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblNotification,
          textStyle: context.textTheme.displaySmall!,
          textAlign: TextAlign.start,
        ),
        withBack: true,
        centerTitle: true,
        customActionWidget: BlocConsumer<NotificationCubit, NotificationStates>(
          listener: (notificationCtx, notificationState) {},
          builder:
              (notificationCtx, notificationState) =>
                  notificationState is NotificationLoadingState ||
                          notificationState is NotificationErrorState ||
                          notificationState is NotificationEmptyState
                      ? const SizedBox()
                      : InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          notificationCubit.clearAllNotificationList();
                        },
                        child: SizedBox(
                          width: getWidgetWidth(60),
                          height: getWidgetHeight(30),
                          child: Center(
                            child: CommonTitleText(
                              textKey:
                                  AppLocalizations.of(context)!.lblClearAll,
                              textStyle: context.textTheme.bodyMedium!.copyWith(
                                color: AppConstants.warningColor,
                              ),
                            ),
                          ),
                        ),
                      ),
        ),
        actionPadding: AppConstants.padding8,
      ),
      body: BlocConsumer<NotificationCubit, NotificationStates>(
        listener: (notificationCtx, notificationState) {
          if (notificationState is NotificationErrorState) {
            checkUserAuth(
              context: notificationCtx,
              errorType: notificationState.error!.type,
            );
          } else if (notificationState is ClearNotificationSuccessState) {
            notificationCubit.getNotificationList();
          } else if (notificationState is DeleteNotificationErrorState) {
            showSnackBar(
              context: notificationCtx,
              title: notificationState.error!.errorMassage!,
              color: AppConstants.lightRedColor,
            );
          } else if (notificationState is ReadNotificationErrorState) {
            checkUserAuth(
              context: notificationCtx,
              errorType: notificationState.error!.type,
            );
            showSnackBar(
              context: notificationCtx,
              title: notificationState.error!.errorMassage!,
              color: AppConstants.lightRedColor,
            );
          }
        },
        builder: (notificationCtx, notificationState) {
          if (notificationState is NotificationErrorState) {
            return CommonError(
              errorMassage: notificationState.error!.errorMassage,
              withButton: true,
              onTap: () => notificationCubit.getNotificationList(),
            );
          } else if (notificationState is NotificationLoadingState) {
            return ListLoaderWidget(
              itemCount: 10,
              itemHeight: getWidgetHeight(65),
              itemRadius: AppConstants.borderRadius16,
              padding: EdgeInsets.symmetric(
                vertical: getWidgetHeight(8),
                horizontal: getWidgetWidth(AppConstants.padding16),
              ),
            );
          } else if (notificationState is NotificationEmptyState) {
            return EmptyScreen(
              titleKey: AppLocalizations.of(context)!.lblNoNotification,
              imageString: 'empty_notification.svg',
              imageHeight: 125,
              imageWidth: 180,
            );
          } else {
            return RefreshIndicator(
              color: AppConstants.mainColor,
              onRefresh: notificationCubit.onRefresh,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: getWidgetHeight(AppConstants.padding16),
                ),
                shrinkWrap: true,
                controller: notificationCubit.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: notificationCubit.notificationList.length + 1,
                separatorBuilder: (context, index) {
                  return getSpaceHeight(AppConstants.padding8);
                },
                itemBuilder: (context, index) {
                  if (index >= notificationCubit.notificationList.length &&
                      notificationCubit.hasMoreData) {
                    return const CommonLoadingWidget();
                  } else if (index >=
                      notificationCubit.notificationList.length) {
                    return const SizedBox();
                  } else {
                    return NotificationItem(
                      model: notificationCubit.notificationList[index],
                      isLoading: false,
                      isEnable:
                          notificationState
                              is ReadORDeleteNotificationLoadingState,
                      onDelete: () {
                        notificationCubit.deleteNotificationList(
                          notificationId:
                              notificationCubit.notificationList[index].id!,
                        );
                      },
                      onRead: () {
                        notificationCubit.readNotification(
                          notificationId:
                              notificationCubit.notificationList[index].id!,
                        );
                      },
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
