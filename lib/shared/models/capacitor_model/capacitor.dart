import 'package:flutter/foundation.dart';

@immutable
class Capacitor {
  final String? microFarad;
  final String? volt;

  const Capacitor({this.microFarad, this.volt});

  factory Capacitor.fromJson(Map<String, dynamic> json) => Capacitor(
        microFarad: json['microFarad'] as String?,
        volt: json['volt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'microFarad': microFarad,
        'volt': volt,
      };

  Capacitor copyWith({
    String? microFarad,
    String? volt,
  }) {
    return Capacitor(
      microFarad: microFarad ?? this.microFarad,
      volt: volt ?? this.volt,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Capacitor) return false;
    return other.microFarad == microFarad && other.volt == volt;
  }

  @override
  int get hashCode => microFarad.hashCode ^ volt.hashCode;
}
