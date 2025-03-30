import 'package:clean_arch_demo_las_version/core/constants/app_constants.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_title_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';

class FirebaseNotificationServices {
  static FirebaseNotificationServices? instance;

  /// Private Constructor
  FirebaseNotificationServices._internal() {
    devLog('Private Constructor');
  }

  static FirebaseNotificationServices getInstance() {
    instance ??= FirebaseNotificationServices._internal();

    return instance!;
  }

  /// [registerNotification] register firebase notification
  void registerNotification() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    onMessageClick();
    setupInteractMessage();
  }

  // Handle tap on notification when app is in background or terminated.
  /// [setupInteractMessage] is a function that handle the tap on notification when app is in background or terminated.
  Future<void> setupInteractMessage() async {
    // When app is terminated.
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      devLog('Handling a background message: ${initialMessage.toMap()}');

      handleMessage(initialMessage);
    }

    // When app is in background.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      devLog('Handling a background message: ${event.toMap()}');

      handleMessage(event);
    });
  }

  /// [handleMessage] is a function that handle the tap on notification when app is in background or terminated.
  Future<void> handleMessage(RemoteMessage message) async {
    devLog('Handling a background message: ${message.data}');

    /// TODO: Add navigation to navigate when the user click on the message when app is in background or terminated.
  }

  /// [firebaseMessagingBackgroundHandler] is a function that handle the background message.
  @pragma('vm:entry-point')
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    /// TODO: Initialize your app here

    devLog('Handling a background message: 77 ${message.toMap()}');
  }

  /// [initLocalNotification] is a function that initialize the local notification.
  Future<void> initLocalNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          'Community',
          'Community',
          importance: Importance.max,
          playSound: true,
          showBadge: true,
          enableLights: true,
          enableVibration: true,
          ledColor: AppConstants.lightWhiteColor,
        );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  /// [firebaseInit] is a function that initialize the firebase messaging.
  /// And it listen to the messages that are received from firebase when the app is in foreground.
  void onMessageClick() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      try {
        devLog('Notification : ${message.toMap()}');
        // For displaying the notification as an overlay.
        showSimpleNotification(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonTitleText(textKey: 'title'),
              getSpaceWidth(5),
              const CommonTitleText(textKey: 'message'),
            ],
          ),
          duration: const Duration(milliseconds: 1500),
          slideDismissDirection: DismissDirection.up,
          background: AppConstants.mainColor,
          contentPadding: const EdgeInsets.all(AppConstants.padding8),
          elevation: 0,
        );
      } catch (e) {
        devLog('Notification error : $e');
      }
    });
  }
}
