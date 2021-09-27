import '../../../../shared/models/induction_motor_model/induction_motor.dart';

class BarangMasuk {
  final String? id;
  final String? ownerName;
  final String? ownerAddress;
  final String? dateIn;
  final InductionMotor? inductionMotor;
  const BarangMasuk({
    this.id,
    this.ownerName,
    this.ownerAddress,
    this.dateIn,
    this.inductionMotor,
  });
  @override
  String toString() {
    return 'BarangMasuk(id: $id, ownerName: $ownerName, ownerAddress: $ownerAddress, dateIn: $dateIn, inductionMotor: $inductionMotor)';
  }

  factory BarangMasuk.fromJson(Map<String, dynamic> json) => BarangMasuk(
        id: json['id'] as String?,
        ownerName: json['ownerName'] as String?,
        ownerAddress: json['ownerAddress'] as String?,
        dateIn: json['dateIn'] as String?,
        inductionMotor: json['inductionMotor'] == null
            ? null
            : InductionMotor.fromJson(
                json['inductionMotor'] as Map<String, dynamic>),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerName': ownerName,
        'ownerAddress': ownerAddress,
        'dateIn': dateIn,
        'inductionMotor': inductionMotor?.toJson(),
      };
}
