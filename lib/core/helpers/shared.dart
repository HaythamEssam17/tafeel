import 'dart:developer' as developer;
import 'dart:io';

import 'package:tafeal/core/model/app_security_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_device/safe_device.dart';
import 'package:share_plus/share_plus.dart';

import 'shared_texts.dart';

void devLog(String errorMessage) {
  developer.log('developer log: $errorMessage');
}

/// Get Widget Height
double getWidgetHeight(double height) {
  return SharedText.screenHeight * (height / 812);
}

/// Get Widget Width
double getWidgetWidth(double width) {
  return SharedText.screenWidth * (width / 375);
}

/// Get Space Height
SizedBox getSpaceHeight(double height) {
  final double currentHeight = SharedText.screenHeight * (height / 812);
  return SizedBox(height: currentHeight);
}

/// Get Space Width
SizedBox getSpaceWidth(double width) {
  final double currentWidth = SharedText.screenWidth * (width / 375);
  return SizedBox(width: currentWidth);
}

/// This function is to check the app security.
Future<bool> checkAppSecurity({
  required AppSecurityModel paramsAppCheck,
}) async {
  bool isEmulated = false;
  bool isJailBroken = false;
  bool canMockLocation = false;
  bool onDevMode = false;
  bool onExternalStorage = false;

  try {
    if (paramsAppCheck.isEmulated) {
      isEmulated = await SafeDevice.isRealDevice;
      devLog('Security - isRealDevice: $isEmulated');
    }
    if (paramsAppCheck.isRooted) {
      isJailBroken = await SafeDevice.isJailBroken;
      devLog('Security - isJailBroken: $isJailBroken');
    }
    if (paramsAppCheck.canMockLocation) {
      canMockLocation = await SafeDevice.isMockLocation;
      devLog('Security - canMockLocation: $canMockLocation');
    }
    if (paramsAppCheck.onDevMode) {
      onDevMode = await SafeDevice.isDevelopmentModeEnable;
      devLog('Security - onDevMode: $onDevMode');
    }
    if (paramsAppCheck.onExternalStorage) {
      onExternalStorage = await SafeDevice.isOnExternalStorage;
      devLog('Security - onExternalStorage: $onExternalStorage');
    }

    final bool result =
        (isEmulated ||
            isJailBroken ||
            canMockLocation ||
            onDevMode ||
            onExternalStorage) ==
        true;

    return result;
  } catch (e) {
    devLog('App Security Failure --- $e');

    return false;
  }
}

/// This function is to set the current screen route and send it to Firebase_Analytics
// Future<void> setCurrentScreen(
//   String firebaseScreenName,
//   String firebaseScreenClass,
// ) async {
//   return FirebaseAnalytics.instance.logScreenView(
//     screenName: firebaseScreenName,
//     screenClass: firebaseScreenClass,
//   );
// }

/// [getDeviceId] is a function that get the device id.
Future<String?> getDeviceId() async {
  String? deviceId;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidDeviceInfo =
        await deviceInfoPlugin.androidInfo;
    deviceId =
        androidDeviceInfo.serialNumber == 'unknown'
            ? androidDeviceInfo.id
            : '${androidDeviceInfo.id}@${androidDeviceInfo.serialNumber}';
  } else if (Platform.isIOS) {
    final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor;
  }

  return deviceId;
}

/// [shareInformation] is a function that share the given value.
Future<void> shareInformation(String text, String subject) {
  return Share.share(text, subject: subject);
}

Future<String?> getSavedDir() async {
  String? externalStorageDirPath;
  externalStorageDirPath =
      (await getApplicationDocumentsDirectory()).absolute.path;

  return externalStorageDirPath;
}

Future<String> prepareSaveDir() async {
  final String localPath = (await getSavedDir())!;
  final savedDir = Directory(localPath);
  if (!savedDir.existsSync()) {
    await savedDir.create();
  }

  return localPath;
}

Future<bool> checkPermission(Permission permission) async {
  if (Platform.isIOS) {
    return true;
  }

  if (Platform.isAndroid) {
    final info = await DeviceInfoPlugin().androidInfo;
    if (info.version.sdkInt > 28) {
      return true;
    }

    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      return true;
    }

    final result = await permission.request();
    result == PermissionStatus.granted;

    return result == PermissionStatus.granted;
  }

  throw StateError('unknown platform');
}

Future<bool> retryRequestPermission(Permission permission) async {
  final bool hasGranted = await checkPermission(permission);

  if (hasGranted) {
    await prepareSaveDir();
  }

  return hasGranted;
}
