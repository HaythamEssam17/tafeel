import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

extension ColorExtensions on ColorScheme {
  Color getStepperCircleColor(int index, int currentStep) {
    Color color;
    if ((index + 1) < currentStep) {
      color = AppColors.lightBlueColor;
    } else if ((index + 1) == currentStep) {
      color = AppColors.lightWhiteColor;
    } else {
      color = AppColors.greyColor;
    }
    return color;
  }

  Color getStepperBorderColor(int index, int currentStep) {
    Color color;
    if ((index + 1) <= currentStep) {
      color = AppColors.lightBlueColor;
    } else {
      color = AppColors.greyColor;
    }
    return color;
  }

  Color getStepperLineColor(int index, int currentStep) {
    Color color;
    if ((index + 1) < currentStep) {
      color = AppColors.lightBlueColor;
    } else {
      color = AppColors.greyColor;
    }

    return color;
  }

  Color getColorFromHex(String hexColor) {
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.replaceAll('#', '');
    }
    if (hexColor.length == 6) {
      hexColor = '0XFF$hexColor';
    }
    return Color(int.parse(hexColor));
  }
}
