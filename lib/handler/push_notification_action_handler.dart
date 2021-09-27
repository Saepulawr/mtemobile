import 'package:get/get.dart';
import 'package:mtelektrik/config/routes.dart';
import 'package:mtelektrik/handler/logger_handler.dart';
import 'package:mtelektrik/shared/utils/push_notification/models/push_notification_action_model/models/push_notification_action_model.dart';

void pushNotificationActionHandler(PushNotificationActionModel data) {
  printInfo(data.toJson());
  //open page by routes name
  if (routes.containsKey(data.openPage)) {
    Get.toNamed(data.openPage!,
        arguments: data.payloadData,
        preventDuplicates: data.preventDuplicatePage!);
  } else {
    //jika page tidak ada
    switch (data.openPage) {
      case "dialog":
        break;
    }
  }
}
