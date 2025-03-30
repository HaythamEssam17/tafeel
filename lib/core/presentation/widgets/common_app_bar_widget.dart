import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/shadow_bordered_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/asset_paths/icon_path.dart';
import '../../helpers/shared.dart';
import '../../helpers/shared_texts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBack;
  final bool withNotification;
  final bool centerTitle;
  final Widget? customActionWidget;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final String? sourcePage;
  final double elevation;
  final double actionPadding;
  final double? leadingWidth;
  final Color? backGroundColor;
  final Function()? onBackPressed;

  const CommonAppBar({
    super.key,
    this.onBackPressed,
    this.withBack = true,
    this.titleWidget,
    this.withNotification = false,
    this.centerTitle = true,
    this.sourcePage = '',
    this.leadingWidget,
    this.elevation = 0,
    this.leadingWidth,
    this.customActionWidget,
    this.actionPadding = AppConstants.padding16,
    this.backGroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor!,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: withBack,
      titleSpacing: 0,
      leadingWidth: withBack ? getWidgetWidth(40) : leadingWidth,
      leading:
          withBack
              ? FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: AppConstants.padding16),
                    GestureDetector(
                      onTap: onBackPressed ?? () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(AppConstants.padding8),
                        decoration: const BoxDecoration().appBarBackArrow(),
                        child: RotatedBox(
                          quarterTurns:
                              SharedText.currentLocale == "ar" ? 0 : 2,
                          child: const CommonAssetSvgImageWidget(
                            imageString: IconPathsSVG.rightArrowIcon,
                            height: 24,
                            imageColor: AppConstants.mainColor,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : leadingWidget != null
              ? Row(
                children: [
                  getSpaceWidth(AppConstants.padding16),
                  leadingWidget ?? const SizedBox(),
                ],
              )
              : const SizedBox(),
      title: titleWidget,
      actions: [
        if (withNotification)
          GestureDetector(
            onTap: () {
              context.pushNamed(RouteNames.notificationListScreenRoute);
            },
            child: Container(
              width: getWidgetHeight(32),
              height: getWidgetHeight(32),
              decoration: BoxDecoration(
                color: AppConstants.lightWhiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.lightBlackColor.withAlpha(8),
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
              child: const CommonAssetSvgImageWidget(
                imageString: IconPathsSVG.notificationIcon,
                height: 16,
                imageColor: AppConstants.mainColor,
                width: 16,
              ),
            ),
          ),
        customActionWidget ?? const SizedBox(),
        SizedBox(width: actionPadding),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Size get bottomSize => const Size.fromHeight(kToolbarHeight + 14);

  Size get emptyBottomSize => const Size.fromHeight(0);
}
