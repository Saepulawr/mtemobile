import 'package:mtemobile/shared/models/customer_model/customer.dart';
import 'package:mtemobile/shared/models/induction_motor_model/induction_motor.dart';

class DataInputBarangMasukModel {
  final Customer? customer;
  final List<String>? images;
  final InductionMotor? inductionMotor;
  const DataInputBarangMasukModel({
    this.customer,
    this.images,
    this.inductionMotor,
  });
  @override
  String toString() {
    return 'DataInputBarangMasukModel(customer: $customer, inductionMotor: $inductionMotor)';
  }

  factory DataInputBarangMasukModel.fromJson(Map<String, dynamic> json) =>
      DataInputBarangMasukModel(
        customer: json['customer'] == null
            ? null
            : Customer.fromJson(json['customer'] as Map<String, dynamic>),
        images: List.from(json['images']).map((e) => e.toString()).toList(),
        inductionMotor: json['inductionMotor'] == null
            ? null
            : InductionMotor.fromJson(
                json['inductionMotor'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => {
        'customer': customer?.toJson(),
        'inductionMotor': inductionMotor?.toJson(),
      };
  DataInputBarangMasukModel copyWith({
    Customer? customer,
    List<String>? images,
    InductionMotor? inductionMotor,
  }) {
    return DataInputBarangMasukModel(
      customer: customer ?? this.customer,
      images: images ?? this.images,
      inductionMotor: inductionMotor ?? this.inductionMotor,
    );
  }
}
