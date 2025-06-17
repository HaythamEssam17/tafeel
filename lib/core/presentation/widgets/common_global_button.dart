import 'package:tafeal/core/helpers/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:tafeal/core/helpers/l10n/app_localizations.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';
import 'common_title_text.dart';

class CommonGlobalButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressedFunction;
  final Color? buttonBackgroundColor;
  final Color? onPressedColor;
  final Color? shadowBackgroundColor;
  final double? elevation;
  final double? width;
  final double? height;
  final Color? buttonTextColor;
  final double? buttonTextSize;
  final FontWeight? buttonTextFontWeight;
  final Color? iconColor;
  final double? radius;
  final Widget? icon;
  final double? spaceSize;
  final bool isLoading;
  final bool isEnable;
  final bool showBorder;
  final Color? borderColor;

  const CommonGlobalButton({
    super.key,
    required this.buttonText,
    required this.onPressedFunction,
    this.buttonBackgroundColor = AppColors.mainColor,
    this.onPressedColor,
    this.shadowBackgroundColor,
    this.elevation = 0.0,
    this.width = 343,
    this.height = 40,
    this.iconColor = AppColors.lightWhiteColor,
    this.buttonTextColor = AppColors.lightWhiteColor,
    this.buttonTextFontWeight = FontWeight.w400,
    this.buttonTextSize = AppConstants.fontSize14,
    this.icon,
    this.radius = AppConstants.borderRadius24,
    this.spaceSize = 8.0,
    this.isLoading = false,
    this.isEnable = true,
    this.showBorder = false,
    this.borderColor = AppColors.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = getWidgetWidth(width!);
    final double buttonHeight = getWidgetHeight(height!);

    return ElevatedButton(
      onPressed: isLoading || !isEnable ? null : onPressedFunction,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(elevation!),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(
            width: 1,
            color:
                showBorder
                    ? isLoading || !isEnable
                        ? AppColors.shadowColor
                        : borderColor!
                    : AppColors.transparent,
          ),
        ),
        shadowColor: WidgetStateProperty.all(
          shadowBackgroundColor ?? AppColors.greyColor.withOpacity(.3),
        ),
        overlayColor: WidgetStateProperty.all(
          onPressedColor ?? AppColors.greyColor.withOpacity(.25),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
        ),
        fixedSize: WidgetStateProperty.all<Size>(
          Size(buttonWidth, buttonHeight),
        ),
        backgroundColor:
            isLoading || !isEnable
                ? WidgetStateProperty.all(AppColors.shadowColor)
                : WidgetStateProperty.all(
                  buttonBackgroundColor ?? AppColors.mainColor,
                ),
      ),
      child:
          icon != null
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isLoading) icon!,
                  getSpaceWidth(spaceSize!),
                  CommonTitleText(
                    textKey:
                        isLoading
                            ? AppLocalizations.of(context)!.lblLoading
                            : buttonText,
                    textStyle: context.textTheme.bodyMedium!.copyWith(
                      fontSize: buttonTextSize!,
                      fontWeight: buttonTextFontWeight!,
                      color:
                          isEnable
                              ? isLoading
                                  ? AppColors.greyColor
                                  : buttonTextColor!
                              : AppColors.greyColor,
                    ),
                  ),
                ],
              )
              : CommonTitleText(
                textKey:
                    isLoading
                        ? AppLocalizations.of(context)!.lblLoading
                        : buttonText,
                textStyle: context.textTheme.bodyMedium!.copyWith(
                  fontSize: buttonTextSize!,
                  fontWeight: buttonTextFontWeight!,
                  color:
                      isEnable
                          ? isLoading
                              ? AppColors.greyColor
                              : buttonTextColor!
                          : AppColors.greyColor,
                ),
              ),
    );
  }
}
