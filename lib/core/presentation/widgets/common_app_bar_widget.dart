import 'package:tafeal/core/constants/asset_paths/image_paths.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';
import 'Images/common_asset_image_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBack;
  final bool withAction;
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
    this.withAction = false,
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
      // leadingWidth: withBack ? getWidgetWidth(40) : leadingWidth,
      leading:
          withBack
              ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              )
              : null,
      actions: [
        if (withAction)
          Container(
            height: 48,
            width: 48,
            padding: EdgeInsets.all(AppConstants.padding8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightWhiteColor,
            ),
            child: Center(
              child: CommonAssetImageWidget(
                imageString: ImagePaths.logoPNG,
                height: 34,
                width: 34,
              ),
            ),
          ),
        getSpaceWidth(AppConstants.padding8),
      ],
      title: titleWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Size get bottomSize => const Size.fromHeight(kToolbarHeight + 14);

  Size get emptyBottomSize => const Size.fromHeight(0);
}
