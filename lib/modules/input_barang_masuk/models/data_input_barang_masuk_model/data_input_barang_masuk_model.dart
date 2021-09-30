import 'package:mtemobile/shared/models/induction_motor_model/induction_motor.dart';

import 'owner.dart';

class DataInputBarangMasukModel {
  final Owner? owner;
  final List<String>? images;
  final InductionMotor? inductionMotor;
  const DataInputBarangMasukModel({
    this.owner,
    this.images,
    this.inductionMotor,
  });
  @override
  String toString() {
    return 'DataInputBarangMasukModel(owner: $owner, inductionMotor: $inductionMotor)';
  }

  factory DataInputBarangMasukModel.fromJson(Map<String, dynamic> json) =>
      DataInputBarangMasukModel(
        owner: json['owner'] == null
            ? null
            : Owner.fromJson(json['owner'] as Map<String, dynamic>),
        images: List.from(json['images']).map((e) => e.toString()).toList(),
        inductionMotor: json['inductionMotor'] == null
            ? null
            : InductionMotor.fromJson(
                json['inductionMotor'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => {
        'owner': owner?.toJson(),
        'inductionMotor': inductionMotor?.toJson(),
      };
}
