import 'package:flutter/foundation.dart';

@immutable
class PushNotificationActionModel {
  final String? openPage;
  final bool? preventDuplicatePage;
  final dynamic payloadData;

  const PushNotificationActionModel(
      {this.openPage, this.payloadData, this.preventDuplicatePage = false});

  factory PushNotificationActionModel.fromJson(Map<String, dynamic> json) =>
      PushNotificationActionModel(
        openPage: json['openPage'] as String?,
        preventDuplicatePage: json['preventDuplicatePage'].toString() == "true",
        payloadData: json['payloadData'],
      );

  Map<String, dynamic> toJson() => {
        'openPage': openPage,
        'preventDuplicatePage': preventDuplicatePage,
        'payloadData': payloadData,
      };

  PushNotificationActionModel copyWith({
    String? openPage,
    bool? preventDuplicatePage,
    dynamic payloadData,
  }) {
    return PushNotificationActionModel(
      openPage: openPage ?? this.openPage,
      preventDuplicatePage: preventDuplicatePage ?? this.preventDuplicatePage,
      payloadData: payloadData ?? this.payloadData,
    );
  }
}
