import 'package:flutter/foundation.dart';

@immutable
class Customer {
  final String? id;
  final String? name;
  final String? address;
  final String? email;
  final String? telp;

  const Customer({this.id, this.name, this.address, this.email, this.telp});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'] as String?,
        name: json['name'] as String?,
        address: json['address'] as String?,
        email: json['email'] as String?,
        telp: json['telp'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'email': email,
        'telp': telp,
      };

  Customer copyWith({
    String? id,
    String? name,
    String? address,
    String? email,
    String? telp,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      telp: telp ?? this.telp,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Customer) return false;
    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.email == email &&
        other.telp == telp;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      email.hashCode ^
      telp.hashCode;
}
