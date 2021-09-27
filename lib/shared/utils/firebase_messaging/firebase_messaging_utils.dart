import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingUtils {
  static Future<void> init(
      {required void Function(RemoteMessage? message) onReceiveMessage}) async {
    await Firebase.initializeApp();
    FirebaseMessaging.onMessage.listen(onReceiveMessage);
  }

  static getInitialMessage(
      {required void Function(RemoteMessage? message) onReceiveMessage}) async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) onReceiveMessage(initialMessage);
  }

  static Future<String?> getFcmToken() async =>
      FirebaseMessaging.instance.getToken();
}
