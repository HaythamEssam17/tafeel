import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/Images/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';
import 'common_global_button.dart';
import 'common_title_text.dart';

class CommonError extends StatelessWidget {
  final String? errorMassage;
  final bool? withButton;
  final Function()? onTap;

  const CommonError({
    super.key,
    this.errorMassage,
    this.withButton = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: CommonAssetSvgImageWidget(
            imageString: "error_icon.svg",
            height: 220,
            width: 280,
            fit: BoxFit.fill,
          ),
        ),
        getSpaceHeight(AppConstants.padding16),
        CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblTechnicalError,
          textStyle: context.textTheme.displayMedium!,
          textOverflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        getSpaceHeight(AppConstants.padding8),
        Row(
          children: [
            Expanded(
              child: CommonTitleText(
                textKey:
                    errorMassage == null
                        ? AppLocalizations.of(context)!.lblWrongHappen
                        : errorMassage!.isEmpty
                        ? AppLocalizations.of(context)!.lblWrongHappen
                        : errorMassage!,
                textStyle: context.textTheme.headlineMedium!,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
        if (withButton!) ...[
          getSpaceHeight(AppConstants.padding16),
          CommonGlobalButton(
            onPressedFunction: onTap ?? () {},
            buttonText: AppLocalizations.of(context)!.lblTryAgain,
          ),
        ],
      ],
    );
  }
}
