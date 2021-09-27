import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mtelektrik/shared/utils/push_notification/models/push_notification_action_model/models/push_notification_action_model.dart';

class PushNotification {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void Function(PushNotificationActionModel data)? _onSelectNotification;
  static Future<void> init(
      {required void Function(PushNotificationActionModel data)
          onSelectNotification}) async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        if (payload != null)
          onSelectNotification(
              PushNotificationActionModel.fromJson(jsonDecode(payload)));
        return Future.value(payload != null);
      },
    );
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);

    _onSelectNotification = onSelectNotification;
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        if (payload != null)
          _onSelectNotification!(
              PushNotificationActionModel.fromJson(jsonDecode(payload)));
        return Future.value(payload != null);
      },
    );
  }

  static Future<List<PendingNotificationRequest>>
      getPendingNotification() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  static Future<int> getNewNotificationId() async {
    final pendings = await getPendingNotification();
    int newId = 0;

    await Future.doWhile(() {
      newId = Random.secure().nextInt(1000);
      for (final pending in pendings) {
        if (newId == pending.id) return true; //get next id
      }
      return false; //exit dowhile
    });
    return newId;
  }

  static Future<void> hideNotification({required int id}) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> hideAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> showNotification({
    required int notificationId,
    required String title,
    required String body,
    required PushNotificationActionModel actionData,
    Importance importance = Importance.max,
    Priority priority = Priority.high,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: untuk ios nanti dulu
    );
    await _flutterLocalNotificationsPlugin.show(
        notificationId, title, body, platformChannelSpecifics,
        payload: jsonEncode(actionData));
  }

  static Future<NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() async {
    return await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
  }

  static Future<void> handlingAppLaunchedViaNotification(
      {required void Function(PushNotificationActionModel data) onData}) async {
    final detail = await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();

    if (detail != null) {
      if (detail.didNotificationLaunchApp && detail.payload != null) {
        onData(
            PushNotificationActionModel.fromJson(jsonDecode(detail.payload!)));
      }
    }
  }
}
