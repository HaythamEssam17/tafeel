import '../../constants/app_constants.dart';
import '../../helpers/shared.dart';

import 'package:flutter/material.dart';

void showBottomModalSheet(
    {required BuildContext context,
    required double height,
    required List<Widget> children,
    TextStyle? textStyle,
    Color bgColor = Colors.white}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(AppConstants.borderRadius15),
      topRight: Radius.circular(AppConstants.borderRadius15),
    )),
    builder: (builder) {
      return Container(
        height: getWidgetHeight(height),
        padding: const EdgeInsets.symmetric(vertical: AppConstants.padding16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppConstants.borderRadius15),
            topRight: Radius.circular(AppConstants.borderRadius15),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      );
    },
  );
}
