import 'package:tafeal/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:tafeal/core/helpers/l10n/app_localizations.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/asset_paths/icon_path.dart';
import '../../../helpers/validators/validators.dart';
import '../common_text_form_field_widget.dart';

class NameFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final String? Function(String?)? nameOnChanged;

  const NameFormWidget({
    Key? key,
    required this.nameController,
    required this.nameOnChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: nameController,
      hintKey: AppLocalizations.of(context)!.lblFullName,
      keyboardType: TextInputType.text,
      prefixIcon: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPathsSVG.personIcon,
          imageColor: AppColors.mainColor,
          fit: BoxFit.contain,
          height: 22,
          width: 22,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.lblFieldIsEmpty;
        } else if (nameValidator(value)) {
          return 'AppLocalizations.of(context)!.lblNameBadFormat';
        } else if (value.length < 2) {
          return 'AppLocalizations.of(context)!.lblNameLength';
        } else {
          return null;
        }
      },
      onChanged: nameOnChanged,
    );
  }
}
