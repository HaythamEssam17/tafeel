import 'package:clean_arch_demo_las_version/core/helpers/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helpers/shared.dart';
import '../../../../core/presentation/widgets/common_title_text.dart';

class SideMenuSection extends StatelessWidget {
  final String sectionHeader;
  final List<Widget> children;

  const SideMenuSection({
    super.key,
    required this.sectionHeader,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///spacer
        getSpaceHeight(8),

        ///header
        CommonTitleText(
          textKey: sectionHeader,
          textStyle: context.textTheme.titleMedium!.copyWith(
            color: AppConstants.sideHeaderTextColor,
          ),
        ),

        ///spacer
        getSpaceHeight(8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidgetWidth(16)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: getWidgetWidth(8)),
            decoration: BoxDecoration(
              color: AppConstants.lightWhiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.lightBlackColor.withAlpha(8),
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}
