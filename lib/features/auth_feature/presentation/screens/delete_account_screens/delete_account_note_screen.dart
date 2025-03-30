import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_argument_model.dart';
import 'package:clean_arch_demo_las_version/core/presentation/routes/route_names.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_global_button.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/presentation/widgets/common_app_bar_widget.dart';

class DeleteAccountNoteScreen extends StatelessWidget {
  final RouteArgument routeArgument;

  const DeleteAccountNoteScreen({super.key, required this.routeArgument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblDeleteAccount,
          textStyle: context.textTheme.headlineMedium!,
        ),
      ),
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              getSpaceHeight(32),
              CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblWriteYourNotes,
                textStyle: context.textTheme.bodyMedium!.copyWith(
                  color: AppConstants.reasonsLightGreyColor,
                  height: 1.8,
                ),
                maxLines: 5,
              ),
              getSpaceHeight(360),
              CommonGlobalButton(
                buttonText: AppLocalizations.of(context)!.lblDeleteAccount,
                onPressedFunction: () => context.pushNamed(
                    RouteNames.deleteAccountEnterPasswordScreenRoute, routeArgument),
                buttonTextColor: AppConstants.lightRedColor,
                buttonBackgroundColor: AppConstants.transparent,
                borderColor: AppConstants.lightRedColor,
                showBorder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
