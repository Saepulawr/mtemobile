import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtelektrik/config/language.dart';
import 'package:mtelektrik/handler/firebase_messaging_handler.dart';
import 'package:mtelektrik/handler/push_notification_action_handler.dart';
import 'package:mtelektrik/config/routes.dart';
import 'package:mtelektrik/shared/utils/firebase_messaging/firebase_messaging_utils.dart';
import 'package:mtelektrik/shared/utils/local_storage/local_storage.dart';
import 'package:mtelektrik/shared/utils/push_notification/push_notification.dart';
import 'package:mtelektrik/shared/widgets/after_layout/after_layout.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("loading..."),
      ),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    //urutan code pada segment ini tidak boleh di ubah.
    //initialize local storage
    await LocalStorage.init();

    //load language
    await loadLanguage(AvailableLanguage.indonesia);
    //init push notification
    await PushNotification.init(
        // widgetsBinding: WidgetsBinding.instance!,
        onSelectNotification: pushNotificationActionHandler);
    //init firebase messaging
    await FirebaseMessagingUtils.init(
        onReceiveMessage: firebaseMessageingHandler);

    Get.offAllNamed(RoutesName.mainLayout);
  }
}
