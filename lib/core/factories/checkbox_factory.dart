import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformSwitcher {
  Widget build({required Function(bool?) onChanged, required bool value});

  factory PlatformSwitcher(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidSwitcher();
      case TargetPlatform.iOS:
        return IOSSwitcher();

      default:
        return AndroidSwitcher();
    }
  }
}

class AndroidSwitcher implements PlatformSwitcher {
  @override
  Widget build({required Function(bool?) onChanged, required bool value}) {
    return Checkbox(value: value, onChanged: onChanged);
  }
}

class IOSSwitcher implements PlatformSwitcher {
  @override
  Widget build({required Function(bool?) onChanged, required bool value}) {
    return CupertinoCheckbox(value: value, onChanged: onChanged);
  }
}
