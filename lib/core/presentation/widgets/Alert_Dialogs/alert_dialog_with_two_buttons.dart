import 'package:tafeal_demo/core/constants/app_constants.dart';
import 'package:tafeal_demo/core/helpers/extensions/context_extensions.dart';
import 'package:tafeal_demo/core/helpers/shared.dart';
import 'package:tafeal_demo/core/presentation/widgets/Images/common_asset_image_widget.dart';
import 'package:tafeal_demo/core/presentation/widgets/common_global_button.dart';
import 'package:tafeal_demo/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialogWithTwoButton({
  required BuildContext context,
  String? imagePath,
  double imageWidth = 90.0,
  double imageHeight = 90.0,
  required String title,
  required String description,
  required String firstButtonText,
  required String secondButtonText,
  required Function(BuildContext ctx) firstButtonOnTap,
  required Function(BuildContext ctx) secondButtonOnTap,
  required Color titleTextColor,
  bool showImage = true,
  bool isFirstButtonLoading = false,
  double firstButtonRadius = AppConstants.borderRadius24,
  Color firstButtonColor = AppConstants.lightWhiteColor,
  Color firstButtonBorderColor = AppConstants.lightRedColor,
  Color firstButtonTextColor = AppConstants.lightRedColor,
  Color secondButtonTextColor = AppConstants.mainColor,
}) async {
  return showDialog(
    barrierColor: Colors.black.withOpacity(0.33),
    context: context,
    builder: (contextDialog) {
      return Dialog(
        alignment: Alignment.center,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius4),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: getWidgetWidth(500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Space
              getSpaceHeight(8),

              if (showImage)
                CommonAssetImageWidget(
                  imageString: imagePath!,
                  height: imageHeight,
                  width: imageWidth,
                ),

              /// Space
              getSpaceHeight(16),

              /// Title
              CommonTitleText(
                textKey: title,
                textStyle: context.textTheme.headlineMedium!,
                selectionColor: titleTextColor,
                textAlign: TextAlign.start,
              ),

              /// Space
              getSpaceHeight(4),

              CommonTitleText(
                textKey: description,
                textStyle: context.textTheme.titleMedium!,
                selectionColor: AppConstants.reasonsLightGreyColor,
              ),

              /// Space
              getSpaceHeight(16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Cancel
                  CommonGlobalButton(
                    showBorder: true,
                    borderColor: firstButtonBorderColor,
                    width: 112,
                    buttonTextFontWeight: FontWeight.w400,
                    buttonTextColor: firstButtonTextColor,
                    buttonTextSize: AppConstants.fontSize14,
                    elevation: 0,
                    buttonBackgroundColor: firstButtonColor,
                    buttonText: firstButtonText,
                    onPressedFunction: () {
                      firstButtonOnTap(contextDialog);
                    },
                    height: 32,
                    radius: firstButtonRadius,
                    isLoading: isFirstButtonLoading,
                    isEnable: !isFirstButtonLoading,
                  ),
                  getSpaceWidth(16),

                  /// Confirm
                  CommonGlobalButton(
                    showBorder: true,
                    borderColor: AppConstants.lightWhiteColor,
                    width: 112,
                    buttonTextFontWeight: FontWeight.w400,
                    buttonTextSize: AppConstants.fontSize14,
                    elevation: 0,
                    buttonBackgroundColor: AppConstants.lightWhiteColor,
                    buttonTextColor: secondButtonTextColor,
                    buttonText: secondButtonText,
                    onPressedFunction: () {
                      secondButtonOnTap(contextDialog);
                    },
                    height: 32,
                    isLoading: isFirstButtonLoading,
                    isEnable: !isFirstButtonLoading,
                    radius: AppConstants.borderRadius24,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
