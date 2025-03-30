import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:clean_arch_demo_las_version/core/services/firebase/firebase_notification_services.dart';
import 'package:clean_arch_demo_las_version/core/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static FirebaseService? _instance;

  /// Private constructor to prevent instantiation outside of this class.
  FirebaseService._();

  static FirebaseService get instance {
    _instance ??= FirebaseService._();
    return _instance!;
  }

  /// Initalize Firebase Options
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void requestPermisstion() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  /// [getFCMToken] is a function that Gets the firebase token.
  Future<String?> getFCMToken() async {
    try {
      final String? token = await FirebaseMessaging.instance.getToken();
      devLog('FCM token $token');
      SharedText.deviceToken = token!;
      return token;
    } catch (e) {
      devLog('FCM token error $e');
      return null;
    }
  }

  /// [registerFirebase] register firenase functions
  void registerFirebase() {
    // requestPermisstion();
    getFCMToken();
    FirebaseNotificationServices.instance?.registerNotification();
  }
}
