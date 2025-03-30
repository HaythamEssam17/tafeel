import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';

class AccountItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onTab;
  final Widget? trailingWidget;
  const AccountItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTab,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: getWidgetHeight(40),
        padding: EdgeInsets.symmetric(
          horizontal: getWidgetWidth(AppConstants.padding4),
        ),
        decoration: const BoxDecoration(color: AppConstants.lightGreyTextColor),
        child: Row(
          children: [
            CommonAssetSvgImageWidget(
              imageString: icon,
              height: 24,
              width: 24,
              fit: BoxFit.fill,
              imageColor: AppConstants.mainColor,
            ),
            getSpaceWidth(AppConstants.padding16),

            ///title
            CommonTitleText(
              textKey: title,
              textStyle: context.textTheme.labelLarge!.copyWith(
                color: AppConstants.mainColor,
              ),
            ),
            trailingWidget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
