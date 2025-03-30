import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/asset_paths/icon_path.dart';
import '../common_text_form_field_widget.dart';

class PhoneFormWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final String? Function(String?)? phoneOnChanged;
  final String? hintKey;
  final bool? checkCurrentPhone;
  const PhoneFormWidget({
    super.key,
    required this.phoneController,
    required this.phoneOnChanged,
    this.hintKey,
    this.checkCurrentPhone = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: phoneController,
      hintKey: hintKey ?? AppLocalizations.of(context)!.lblPhone,
      keyboardType: TextInputType.phone,
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(AppConstants.phoneLength),
      ],
      prefixIcon: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPathsSVG.phoneIcon,
          imageColor: AppConstants.mainColor,
          fit: BoxFit.contain,
          height: 22,
          width: 22,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.lblPhoneIsEmpty;
        } else if (value.length != AppConstants.phoneLength) {
          return AppLocalizations.of(context)!.lblPhoneValidate;
        } else if (checkCurrentPhone! &&
            (value != SharedText.currentUser.phone!)) {
          return AppLocalizations.of(context)!.lblWrongPhoneNumber;
        } else {
          return null;
        }
      },
      onChanged: phoneOnChanged,
    );
  }
}
