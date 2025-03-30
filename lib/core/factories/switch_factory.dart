import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class SwitchFactory {
  Widget buildSwitch({required bool value, required Function(bool p1) onChanged});

  factory SwitchFactory(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidSwitch();
      case TargetPlatform.iOS:
        return IOSSwitch();

      default:
        return AndroidSwitch();
    }
  }
}

class AndroidSwitch implements SwitchFactory {
  @override
  Widget buildSwitch({required bool value, required Function(bool p1) onChanged}) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppConstants.lightWhiteColor,
      activeTrackColor: AppConstants.mainColor,
    );
  }
}

class IOSSwitch implements SwitchFactory {
  @override
  Widget buildSwitch({required bool value, required Function(bool p1) onChanged}) {
    return CupertinoSwitch(value: value, onChanged: onChanged);
  }
}

/// Use This in UI
class PlatformSwitch {
  static Widget buildSwitch(
      {required BuildContext context, required bool value, required Function(bool p1) onChanged}) {
    return SwitchFactory(Theme.of(context).platform).buildSwitch(value: value, onChanged: onChanged);
  }
}
