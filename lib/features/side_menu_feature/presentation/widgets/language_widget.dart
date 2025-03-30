import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String imagePath;

  const LanguageItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: getWidgetHeight(40),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppConstants.shadowColor.withAlpha(1),
                blurRadius: 8,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
            color: AppConstants.lightWhiteColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius4),
          ),
          child: Row(
            children: [
              getSpaceWidth(AppConstants.padding16),
              CommonAssetSvgImageWidget(
                imageString: imagePath,
                height: 14,
                width: 20,
              ),
              getSpaceWidth(AppConstants.padding16),
              Expanded(
                child: CommonTitleText(
                  textKey: title,
                  textStyle: context.textTheme.titleMedium!.copyWith(
                    color: AppConstants.reasonsLightGreyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
