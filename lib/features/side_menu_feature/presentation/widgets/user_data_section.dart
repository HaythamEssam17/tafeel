import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/prevent_string_spacing.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/asset_paths/icon_path.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/helpers/shared_texts.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';

class UserDataSection extends StatelessWidget {
  const UserDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getWidgetHeight(227),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppConstants.sectionUserDataColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: AppConstants.lightBlackColor.withAlpha(8),
                blurRadius: 8,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
        ),
        Container(
          height: getWidgetHeight(148),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppConstants.sideHeaderColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(56),
            ),
            boxShadow: [
              BoxShadow(
                color: AppConstants.lightBlackColor.withAlpha(8),
                blurRadius: 8,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: getWidgetHeight(53),
          child: const CommonAssetSvgImageWidget(
            imageString: IconPathsSVG.sideMenuCarIcon,
            height: 88,
            width: 115,
          ),
        ),
        Positioned(
          top: getWidgetHeight(32),
          right: 0,
          left: 0,
          child: Column(
            children: [
              ///spacer
              getSpaceHeight(8),

              ///header
              CommonTitleText(
                textKey:
                    SharedText.currentUser.name!.getStringWithoutSpacings(),
                textStyle: context.textTheme.displayMedium!.copyWith(
                  color: AppConstants.sideHeaderTextColor,
                ),
              ),

              ///spacer
              getSpaceHeight(8),

              GestureDetector(
                onTap: () {
                  context.pushNamed(RouteNames.profilePageRoute);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CommonAssetSvgImageWidget(
                      imageString: IconPathsSVG.settingIcon,
                      height: 16,
                      width: 16,
                    ),
                    getSpaceWidth(4),
                    CommonTitleText(
                      textKey: AppLocalizations.of(context)!.lblProfileSetting,
                      textStyle: context.textTheme.titleMedium!.copyWith(
                        color: AppConstants.lightWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),

              ///spacer
              getSpaceHeight(8),
              CommonCachedImageWidget(
                imageUrl: SharedText.currentUser.image ?? '',
                height: 65,
                width: 65,
                radius: 1000,
                isCircular: true,
                isProfile: true,
              ),

              ///spacer
              getSpaceHeight(8),
            ],
          ),
        ),
      ],
    );
  }
}
