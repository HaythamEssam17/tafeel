import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/keys/api_keys.dart';

class CheckTermsAndConditions extends StatelessWidget {
  const CheckTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CommonTitleText(
        //   textKey: AppLocalizations.of(context)!.lblCheckOur,
        //   textColor: AppConstants.reasonsLightGreyColor,
        //   textFontSize: AppConstants.fontSize12,
        //   textWeight: FontWeight.w500,
        // ),
        // getSpaceWidth(AppConstants.padding2),
        GestureDetector(
          onTap: () {
            context.pushNamed(
              RouteNames.termsAndConditionsPageRoute,
              RouteArgument(
                screenName: AppLocalizations.of(context)!.lblTermsAndConditions,
                endPoint: ApiKeys.termsAndConditionsKey,
              ),
            );
          },
          child: CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblTermsAndConditions,
            textStyle: context.textTheme.titleMedium!.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
