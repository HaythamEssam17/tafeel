import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/shared_texts.dart';

Future<bool> onWillPop(BuildContext context) async {
  final DateTime now = DateTime.now();
  if (SharedText.currentBackPressTime == null ||
      now.difference(SharedText.currentBackPressTime!) >
          const Duration(seconds: 2)) {
    SharedText.currentBackPressTime = now;

    // showFlutterToast(
    //     message: 'Tap again to leave', bgColor: AppConstants.greyColor, textColor: AppConstants.lightBlackColor);

    return Future.value(false);
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return Future.value(true);
}
