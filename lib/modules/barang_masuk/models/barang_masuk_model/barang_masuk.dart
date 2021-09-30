import 'package:mtemobile/shared/models/customer_model/customer.dart';

import '../../../../shared/models/induction_motor_model/induction_motor.dart';

class BarangMasuk {
  final String? id;
  final String? image;
  final Customer? customer;
  final String? dateIn;
  final InductionMotor? inductionMotor;
  const BarangMasuk({
    this.id,
    this.image,
    this.customer,
    this.dateIn,
    this.inductionMotor,
  });
  @override
  String toString() {
    return 'BarangMasuk(id: $id, image : $image, customer: $customer, dateIn: $dateIn, inductionMotor: $inductionMotor)';
  }

  factory BarangMasuk.fromJson(Map<String, dynamic> json) => BarangMasuk(
        id: json['id'] as String?,
        image: json['image'] as String?,
        customer: Customer.fromJson(json['customer']),
        dateIn: json['dateIn'] as String?,
        inductionMotor: json['inductionMotor'] == null
            ? null
            : InductionMotor.fromJson(
                json['inductionMotor'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'customer': customer,
        'dateIn': dateIn,
        'inductionMotor': inductionMotor?.toJson(),
      };
}
