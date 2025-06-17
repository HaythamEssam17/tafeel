import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class CommonTextFormField extends StatelessWidget {
  final String? hintKey;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? textInputColor;
  final Function()? onTap;
  final bool enabled;
  final bool isSelected;
  final bool evaluation;
  final bool isObscureText;
  final bool isDigitOnly;
  final String? Function(String?)? validator;
  final double? fieldWidth;
  final double? fieldHeight;
  final int minLines;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? onChanged;
  final Function()? onSaved;
  final Color? borderColor;
  final Color? filledColor;
  final Color? labelHintStyle;
  final Color? labelErrorStyle;
  final List<TextInputFormatter>? inputFormatter;
  final bool? isReadOnly;
  final TextInputAction? action;
  final TextAlign? labelHintTextAlign;
  final double? radius;
  final bool? alignMultipleLines;
  final FocusNode? fieldFocusNode;
  final double? blurRadius;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final double hintFontSize;
  final Color? focuseAndErrorColor;

  const CommonTextFormField({
    Key? key,
    this.hintKey,
    this.controller,
    this.keyboardType = TextInputType.name,
    this.onTap,
    this.enabled = true,
    this.isSelected = false,
    this.isObscureText = false,
    this.evaluation = true,
    this.fieldWidth,
    this.fieldHeight,
    this.isDigitOnly = false,
    this.minLines = 1,
    this.maxLines = 4,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    this.borderColor = AppColors.borderInputColor,
    this.filledColor = AppColors.lightWhiteColor,
    this.textInputColor = AppColors.textInputColor,
    this.labelHintStyle = AppColors.textInputColor,
    this.labelErrorStyle = AppColors.lightRedColor,
    this.inputFormatter,
    this.isReadOnly = false,
    this.action = TextInputAction.next,
    this.labelHintTextAlign = TextAlign.start,
    this.radius = AppConstants.borderRadius24,
    this.alignMultipleLines = false,
    this.fieldFocusNode,
    this.blurRadius = 40,
    this.shadowColor = AppColors.shadowColor,
    this.shadowOffset = const Offset(0, 8),
    this.contentPaddingHorizontal = 12,
    this.contentPaddingVertical = 14.0,
    this.hintFontSize = AppConstants.fontSize14,
    this.focuseAndErrorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight,
      width: fieldWidth,
      alignment: Alignment.center,
      child: Center(
        child: TextFormField(
          onTap: onTap,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          enabled: enabled,
          onEditingComplete: onSaved,
          keyboardType: keyboardType,
          obscureText: isObscureText,
          onChanged: onChanged,
          readOnly: isReadOnly!,
          textAlign: labelHintTextAlign!,
          focusNode: fieldFocusNode,
          textInputAction: action,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: textInputColor,
            fontSize: AppConstants.fontSize14,
            fontWeight: FontWeight.w500,
          ),
          inputFormatters: inputFormatter,
          validator: validator,
          cursorColor: AppColors.mainColor,
          decoration: InputDecoration(
            labelText: hintKey,
            hintStyle: Theme.of(context).textTheme.titleMedium!
                .copyWith(fontSize: hintFontSize, fontWeight: FontWeight.w500)
                .apply(color: labelHintStyle),
            alignLabelWithHint: alignMultipleLines,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focuseAndErrorColor ?? borderColor!,
                width: 0.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focuseAndErrorColor ?? borderColor!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focuseAndErrorColor ?? borderColor!,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(
                color: focuseAndErrorColor ?? borderColor!,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius!)),
              borderSide: BorderSide(
                color: focuseAndErrorColor ?? AppColors.lightRedColor,
                width: 0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius!)),
              borderSide: BorderSide(
                color: focuseAndErrorColor ?? AppColors.lightRedColor,
                width: 1,
              ),
            ),
            errorStyle: const TextStyle(
              fontSize: AppConstants.fontSize12,
              height: 0.5,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.fade,
            ).apply(color: labelErrorStyle),
            contentPadding: EdgeInsets.symmetric(
              vertical: contentPaddingVertical!,
              horizontal: contentPaddingHorizontal!,
            ),
            fillColor: filledColor!,
            isDense: true,
            filled: true,
            prefixIcon: prefixIcon,
            labelStyle: Theme.of(context).textTheme.titleMedium!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500)
                .apply(color: AppColors.greyColor),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
