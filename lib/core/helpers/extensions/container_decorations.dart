import 'package:tafeal/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

extension ContainerBoxDecoration on BoxDecoration {
  BoxDecoration dateRangeDecoration() {
    return BoxDecoration(
      color: AppColors.dateRangeBGColor,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius28),
    );
  }

  BoxDecoration calendarDecoration() {
    return BoxDecoration(
      color: AppColors.backArrowColor,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: AppColors.lightBlackColor.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
    );
  }
}
