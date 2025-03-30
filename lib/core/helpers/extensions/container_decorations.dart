import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

extension ContainerBoxDecoration on BoxDecoration {
  BoxDecoration dateRangeDecoration() {
    return BoxDecoration(
      color: AppConstants.dateRangeBGColor,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius28),
    );
  }

  BoxDecoration calendarDecoration() {
    return BoxDecoration(
      color: AppConstants.backArrowColor,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: AppConstants.lightBlackColor.withAlpha(8),
          blurRadius: 8,
          offset: const Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
    );
  }
}
