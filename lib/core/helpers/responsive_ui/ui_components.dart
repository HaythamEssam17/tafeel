import 'package:flutter/material.dart';

import 'device_info.dart';
import 'get_device_type.dart';

class InfoComponents extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;

  const InfoComponents({super.key, required this.builder});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        final DeviceInfo deviceInfo = DeviceInfo(
          orientation: mediaQueryData.orientation,
          deviceType: getDeviceType(mediaQueryData),
          screenWidth: mediaQueryData.size.width,
          screenHeight: mediaQueryData.size.height,
          widgetHeight: constrains.maxHeight,
          widgetWidth: constrains.maxWidth,
        );

        return builder(context, deviceInfo);
      },
    );
  }
}
