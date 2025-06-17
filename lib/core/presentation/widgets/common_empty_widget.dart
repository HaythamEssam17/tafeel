import 'package:tafeal/core/helpers/extensions/context_extensions.dart';
import 'package:tafeal/core/helpers/l10n/app_localizations.dart';
import 'package:tafeal/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';
import 'common_global_button.dart';
import 'common_title_text.dart';

class EmptyScreen extends StatelessWidget {
  final String imageString;
  final double imageHeight;
  final double imageWidth;
  final String titleKey;
  final String? description;
  final bool? withButton;
  final Function()? onTap;
  final String? buttonText;

  const EmptyScreen({
    Key? key,
    required this.imageString,
    required this.titleKey,
    required this.imageHeight,
    required this.imageWidth,
    this.description,
    this.withButton = false,
    this.onTap,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getSpaceHeight(80),
        Center(
          child: CommonAssetSvgImageWidget(
            imageString: imageString,
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.fill,
          ),
        ),
        getSpaceHeight(AppConstants.padding24),
        Center(
          child: CommonTitleText(
            textKey: titleKey,
            textStyle: context.textTheme.bodyMedium!,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            selectionColor: AppColors.mainTextColor,
          ),
        ),
        if (description != null) ...[
          getSpaceHeight(AppConstants.padding8),
          Center(
            child: CommonTitleText(
              textKey: description!,
              textStyle: context.textTheme.headlineMedium!,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              selectionColor: AppColors.textInputColor,
            ),
          ),
        ],
        if (withButton!) ...[
          getSpaceHeight(AppConstants.padding8),
          CommonGlobalButton(
            radius: AppConstants.borderRadius8,
            width: 140,
            height: 40,
            buttonBackgroundColor: AppColors.verificationCodeColor,
            onPressedFunction: onTap ?? () {},
            buttonText: buttonText ?? AppLocalizations.of(context)!.lblRetry,
            buttonTextFontWeight: FontWeight.w400,
            elevation: 0,
            buttonTextColor: AppColors.mainColor,
          ),
        ],
      ],
    );
  }
}
