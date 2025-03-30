import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/asset_paths/icon_path.dart';
import '../../../helpers/validators/validators.dart';
import '../common_text_form_field_widget.dart';

class EmailFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final String? Function(String?)? emailOnChanged;

  const EmailFormWidget({
    super.key,
    required this.emailController,
    required this.emailOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      controller: emailController,
      hintKey:
          AppLocalizations.of(context)!.lblEmail +
          AppLocalizations.of(context)!.lblOptional,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: CommonAssetSvgImageWidget(
          imageString: IconPathsSVG.emailIcon,
          fit: BoxFit.contain,
          imageColor: AppConstants.mainColor,
          height: 16,
          width: 16,
        ),
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          if (!validateEmail(value)) {
            return AppLocalizations.of(context)!.lblEmailBadFormat;
          } else {
            return null;
          }
        }
        return null;
      },
      onChanged: emailOnChanged,
    );
  }
}
