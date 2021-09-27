import 'package:flutter/foundation.dart';
import 'package:mtelektrik/shared/utils/push_notification/models/push_notification_action_model/models/push_notification_action_model.dart';

@immutable
class PushNotificationModel {
  final int? id;
  final String? title;
  final String? body;
  final PushNotificationActionModel? action;

  const PushNotificationModel({
    this.id,
    this.title,
    this.body,
    this.action,
  });

  @override
  String toString() {
    return 'PushNotificationModel(id: $id, title: $title, body: $body, action: $action)';
  }

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) =>
      PushNotificationModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
        action: json['action'] == null
            ? null
            : PushNotificationActionModel.fromJson(
                json['action'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'action': action?.toJson(),
      };

  PushNotificationModel copyWith({
    int? id,
    String? title,
    String? body,
    PushNotificationActionModel? action,
  }) {
    return PushNotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      action: action ?? this.action,
    );
  }
}
