import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';

class SideMenuDivider extends StatelessWidget {
  const SideMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppConstants.sectionSplitterColor,
    );
  }
}
