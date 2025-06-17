import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

extension ShadowBorderedWidget on BoxDecoration {
  BoxDecoration appBarBackArrow() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.backArrowColor,
      boxShadow: [
        BoxShadow(
          color: AppColors.lightBlackColor.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }
}
