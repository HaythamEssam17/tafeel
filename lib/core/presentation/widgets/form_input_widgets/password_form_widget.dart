import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/asset_paths/icon_path.dart';
import '../../../helpers/shared.dart';
import '../../../helpers/validators/validators.dart';
import '../common_text_form_field_widget.dart';

class PasswordFormWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final String? Function(String?)? passwordOnChanged;
  final String? Function(String?)? passwordValidator;
  final Function()? onSuffixTap;
  final bool? showPasswordText;
  final String? hintText;
  final Color? borderColor;
  final Color? showPasswordColor;

  const PasswordFormWidget({
    super.key,
    required this.passwordController,
    required this.passwordOnChanged,
    this.passwordValidator,
    this.onSuffixTap,
    this.hintText,
    this.showPasswordText = true,
    this.borderColor = AppConstants.borderInputColor,
    this.showPasswordColor = AppConstants.borderInputColor,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: passwordController,
      suffixIcon:
          onSuffixTap == null
              ? null
              : GestureDetector(
                onTap: onSuffixTap,
                child: SizedBox(
                  width: getWidgetWidth(30),
                  height: getWidgetHeight(30),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      child: CommonAssetSvgImageWidget(
                        imageString:
                            showPasswordText!
                                ? IconPathsSVG.eyeCloseIcon
                                : IconPathsSVG.eyeOpenIcon,
                        height: 30,
                        width: 30,
                        imageColor: showPasswordColor ?? AppConstants.mainColor,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
      keyboardType: TextInputType.text,
      minLines: 1,
      maxLines: 1,
      isObscureText: showPasswordText!,
      radius: AppConstants.borderRadius24,
      labelHintStyle: AppConstants.reasonsLightGreyColor,
      hintFontSize: AppConstants.fontSize14,
      hintKey: hintText ?? AppLocalizations.of(context)!.lblPassword,
      borderColor: borderColor!,
      prefixIcon: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPathsSVG.lockIconIcon,
          imageColor: AppConstants.mainColor,
          fit: BoxFit.contain,
          height: 22,
          width: 22,
        ),
      ),
      validator:
          passwordValidator ??
          (value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.lblPasswordIsEmpty;
            } else if (value.length < AppConstants.passwordMinLength) {
              return AppLocalizations.of(context)!.lblPasswordMustBeMoreThan;
            } else if (complexValidationLowerAndUpperCaseValidator(value)) {
              return AppLocalizations.of(
                context,
              )!.lblComplexPasswordValidationUpperAndLower;
            } else {
              return null;
            }
          },
      onChanged: passwordOnChanged,
    );
  }
}
