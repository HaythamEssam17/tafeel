import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/shared.dart';
import '../../../core/presentation/widgets/common_global_button.dart';
import '../../../core/presentation/widgets/common_title_text.dart';
import '../data/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel model;
  final bool isLoading;
  final bool isEnable;
  final Function() onRead;
  final Function() onDelete;

  const NotificationItem({
    super.key,
    required this.model,
    required this.isLoading,
    required this.onRead,
    required this.onDelete,
    required this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model.id!.toString()),
      direction: isEnable ? DismissDirection.none : DismissDirection.endToStart,
      background: Container(
        color: AppConstants.lightWhiteColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getSpaceWidth(8),
              CommonGlobalButton(
                buttonText: AppLocalizations.of(context)!.lblDelete,
                onPressedFunction: onDelete,
                width: 100,
                radius: 8,
                isEnable: !isEnable,
                height: 100,
                buttonBackgroundColor: AppConstants.lightRedColor,
                // icon: const Icon(Icons.delete),
              ),
              getSpaceWidth(8),
              if (!model.isRead!) ...[
                CommonGlobalButton(
                  buttonText: AppLocalizations.of(context)!.lblMarkAsRead,
                  onPressedFunction: onRead,
                  isEnable: !isEnable,
                  width: 150,
                  radius: 8,
                  height: 100,
                  // icon: const Icon(Icons.mark_chat_read),
                ),
                getSpaceWidth(8),
              ],
            ],
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        await Future.delayed(const Duration(seconds: 2));
        return false;
      },
      child: Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.padding16,
          vertical: AppConstants.padding8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getWidgetHeight(32),
                  width: getWidgetHeight(32),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.sideHeaderColor,
                  ),
                  padding: const EdgeInsets.all(AppConstants.padding8),
                  child: CommonCachedImageWidget(
                    imageUrl: model.icon ?? "",
                    width: 16,
                    height: 16,
                    radius: 1000,
                    isCircular: true,
                    fit: BoxFit.contain,
                    errorImageColor: AppConstants.lightWhiteColor,
                  ),
                ),

                /// Space
                getSpaceWidth(AppConstants.padding8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// title
                      CommonTitleText(
                        textKey: model.title ?? "Order Status",
                        textStyle: context.textTheme.titleMedium!.copyWith(
                          color:
                              model.isRead!
                                  ? AppConstants.sideHeaderColor
                                  : AppConstants.mainColor,
                        ),
                      ),

                      /// Space
                      getSpaceHeight(AppConstants.padding4),

                      /// description
                      CommonTitleText(
                        textKey: model.description ?? "description",
                        textStyle: context.textTheme.bodySmall!.copyWith(
                          color:
                              model.isRead!
                                  ? AppConstants.hintColor
                                  : AppConstants.textInputColor,
                        ),
                      ),

                      /// Space
                      getSpaceHeight(AppConstants.padding4),

                      /// Time
                      CommonTitleText(
                        textKey: model.createdAt ?? "8 hrs ago",
                        textStyle: context.textTheme.bodySmall!.copyWith(
                          color:
                              model.isRead!
                                  ? AppConstants.borderInputColor
                                  : AppConstants.hintColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
