import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mtelektrik/handler/logger_handler.dart';
import 'package:mtelektrik/shared/utils/push_notification/models/push_notification_action_model/models/push_notification_action_model.dart';
import 'package:mtelektrik/shared/utils/push_notification/push_notification.dart';
import 'package:flutter/foundation.dart';

Future<void> firebaseMessageingHandler(RemoteMessage? message) async {
  if (message != null) {
    printWarning(message.data);
    // if (message.data.isEmpty) return;
    final actionData = PushNotificationActionModel.fromJson(message.data);
    try {
      PushNotification.showNotification(
          notificationId: await PushNotification.getNewNotificationId(),
          title: message.notification?.title ?? "",
          body: message.notification?.body ?? "",
          actionData: actionData);
    } catch (e) {
      if (kDebugMode) printError(e);
    }
  }
}
