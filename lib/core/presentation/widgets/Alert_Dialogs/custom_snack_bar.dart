import 'package:tafeal_demo/core/helpers/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../helpers/shared.dart';
import '../common_title_text.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  Color? color,
  double? height = 150,
}) {
  final Color backgroundColor = color ?? AppConstants.mainColor;

  final snackBar = SnackBar(
    content: CommonTitleText(
      textKey: title,
      textStyle: context.textTheme.bodyMedium!.copyWith(
        color: AppConstants.lightWhiteColor,
        fontWeight: FontWeight.w700,
      ),
      maxLines: 2,
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - height!,
      right: getWidgetWidth(16),
      left: getWidgetWidth(16),
    ),
    duration: const Duration(milliseconds: 3500),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
