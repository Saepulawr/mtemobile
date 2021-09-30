import 'data.dart';

class BarangMasukModel {
  final bool? success;
  final Data? data;
  const BarangMasukModel({
    this.success,
    this.data,
  });
  @override
  String toString() {
    return 'BarangMasukModel(success: $success, data: $data)';
  }

  factory BarangMasukModel.fromJson(Map<String, dynamic> json) =>
      BarangMasukModel(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}
