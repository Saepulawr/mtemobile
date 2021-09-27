import 'package:flutter/foundation.dart';

@immutable
class ApiErrorModel {
  final int? errorCode;
  final String? message;

  const ApiErrorModel({this.errorCode, this.message});

  @override
  String toString() {
    return 'ApiErrorModel(errorCode: $errorCode, message: $message)';
  }

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        errorCode: json['errorCode'] as int?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'errorCode': errorCode,
        'message': message,
      };
}
