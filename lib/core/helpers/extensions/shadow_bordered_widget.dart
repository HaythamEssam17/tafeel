import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

extension ShadowBorderedWidget on BoxDecoration {
  BoxDecoration appBarBackArrow() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: AppConstants.backArrowColor,
      boxShadow: [
        BoxShadow(
          color: AppConstants.lightBlackColor.withAlpha(8),
          blurRadius: 8,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }
}
