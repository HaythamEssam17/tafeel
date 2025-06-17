import 'package:tafeal_demo/core/helpers/extensions/context_extensions.dart';
import 'package:tafeal_demo/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/helpers/shared.dart';
import '../../../../../core/presentation/widgets/common_title_text.dart';
import '../../../constants/asset_paths/icon_path.dart';
import '../../../helpers/shared_texts.dart';

class SideMenuItemWidget extends StatelessWidget {
  final String title;
  final Function() onTab;
  final Widget? trailingWidget;
  final Color titleColor;

  const SideMenuItemWidget({
    Key? key,
    required this.title,
    required this.onTab,
    this.titleColor = AppConstants.sideHeaderColor,
    this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTab,
      child: Container(
        height: getWidgetHeight(40),
        padding: EdgeInsets.symmetric(
          vertical: getWidgetWidth(AppConstants.padding8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///title
            CommonTitleText(
              textKey: title,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                color: titleColor,
              ),
            ),
            trailingWidget ??
                Transform.scale(
                  scaleX: SharedText.isARLocal() ? 1 : -1,
                  child: const CommonAssetSvgImageWidget(
                    imageString: IconPathsSVG.rightArrowIcon,
                    height: 24,
                    width: 24,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
