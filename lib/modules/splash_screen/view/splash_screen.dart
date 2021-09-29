import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtemobile/config/language.dart';
import 'package:mtemobile/handler/firebase_messaging_handler.dart';
import 'package:mtemobile/handler/push_notification_action_handler.dart';
import 'package:mtemobile/config/routes.dart';
import 'package:mtemobile/shared/themes/theme.dart';
import 'package:mtemobile/shared/utils/firebase_messaging/firebase_messaging_utils.dart';
import 'package:mtemobile/shared/utils/local_storage/local_storage.dart';
import 'package:mtemobile/shared/utils/push_notification/push_notification.dart';
import 'package:mtemobile/shared/widgets/after_layout/after_layout.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double logoSize = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
        backgroundColor: Themes.primary,
        body: Center(
          child: Column(
            children: [
              Spacer(),
              Image.asset(
                "assets/images/logo.png",
                width: logoSize,
                height: logoSize,
              ),
              // CircularProgressIndicator(
              //   color: Themes.secondary,
              // ),
              Spacer()
            ],
          ),
        ));
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
