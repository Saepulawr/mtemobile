import 'data.dart';
class DataSearchCustomerModel {
  final bool? success;
  final Data? data;
  const DataSearchCustomerModel({
    this.success,
    this.data,
  });
  @override
  String toString() {
    return 'DataSearchCustomerModel(success: $success, data: $data)';
}  factory DataSearchCustomerModel.fromJson(Map<String, dynamic> json) => DataSearchCustomerModel(
success: json['success'] as bool?,
        data: json['data'] == null ? null : Data.fromJson(json['data'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => {
'success': success,
        'data': data?.toJson(),
      };
}