import 'package:tafeal_demo/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

extension ShadowBorderedWidget on BoxDecoration {
  BoxDecoration appBarBackArrow() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: AppConstants.backArrowColor,
      boxShadow: [
        BoxShadow(
          color: AppConstants.lightBlackColor.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }
}
