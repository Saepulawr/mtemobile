import 'package:flutter/foundation.dart';

import '../capacitor_model/capacitor.dart';

@immutable
class InductionMotor {
  final String? id;
  final String? brand;
  final String? model;
  final int? phase;
  final String? insulationClass;
  final String? weight;
  final String? ambientTemperature;
  final String? ip;
  final String? cosPhi;
  final List<String>? poles;
  final List<String>? kw;
  final List<String>? hp;
  final List<String>? rpm;
  final List<String>? volt;
  final List<String>? amps;
  final List<String>? hz;
  final List<String>? connection;
  final List<String>? bearings;
  final List<Capacitor>? capacitor;
  final bool? springCaps;

  const InductionMotor({
    this.id,
    this.brand,
    this.model,
    this.phase,
    this.insulationClass,
    this.weight,
    this.ambientTemperature,
    this.ip,
    this.cosPhi,
    this.poles,
    this.kw,
    this.hp,
    this.rpm,
    this.volt,
    this.amps,
    this.hz,
    this.connection,
    this.bearings,
    this.capacitor,
    this.springCaps,
  });

  factory InductionMotor.fromJson(Map<String, dynamic> json) => InductionMotor(
        id: json['id'] as String?,
        brand: json['brand'] as String?,
        model: json['model'] as String?,
        phase: json['phase'] as int?,
        insulationClass: json['insulationClass'] as String?,
        weight: json['weight'] as String?,
        ambientTemperature: json['ambientTemperature'] as String?,
        ip: json['IP'] as String?,
        cosPhi: json['cosPhi'] as String?,
        poles: List.from(json['poles']).map((e) => e.toString()).toList(),
        kw: List.from(json['kw']).map((e) => e.toString()).toList(),
        hp: List.from(json['hp']).map((e) => e.toString()).toList(),
        rpm: List.from(json['rpm']).map((e) => e.toString()).toList(),
        volt: List.from(json['volt']).map((e) => e.toString()).toList(),
        amps: List.from(json['amps']).map((e) => e.toString()).toList(),
        hz: List.from(json['hz']).map((e) => e.toString()).toList(),
        connection:
            List.from(json['connection']).map((e) => e.toString()).toList(),
        bearings: List.from(json['bearings']).map((e) => e.toString()).toList(),
        capacitor: (json['capacitor'] as List<dynamic>?)
            ?.map((e) => Capacitor.fromJson(e as Map<String, dynamic>))
            .toList(),
        springCaps: json['springCaps'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'model': model,
        'phase': phase,
        'insulationClass': insulationClass,
        'weight': weight,
        'ambientTemperature': ambientTemperature,
        'IP': ip,
        'cosPhi': cosPhi,
        'poles': poles,
        'kw': kw,
        'hp': hp,
        'rpm': rpm,
        'volt': volt,
        'amps': amps,
        'hz': hz,
        'connection': connection,
        'bearings': bearings,
        'capacitor': capacitor?.map((e) => e.toJson()).toList(),
        'springCaps': springCaps,
      };

  InductionMotor copyWith({
    String? id,
    String? brand,
    String? model,
    int? phase,
    String? insulationClass,
    String? weight,
    String? ambientTemperature,
    String? ip,
    String? cosPhi,
    List<String>? poles,
    List<String>? kw,
    List<String>? hp,
    List<String>? rpm,
    List<String>? volt,
    List<String>? amps,
    List<String>? hz,
    List<String>? connection,
    List<String>? bearings,
    List<Capacitor>? capacitor,
    bool? springCaps,
  }) {
    return InductionMotor(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      phase: phase ?? this.phase,
      insulationClass: insulationClass ?? this.insulationClass,
      weight: weight ?? this.weight,
      ambientTemperature: ambientTemperature ?? this.ambientTemperature,
      ip: ip ?? this.ip,
      cosPhi: cosPhi ?? this.cosPhi,
      poles: poles ?? this.poles,
      kw: kw ?? this.kw,
      hp: hp ?? this.hp,
      rpm: rpm ?? this.rpm,
      volt: volt ?? this.volt,
      amps: amps ?? this.amps,
      hz: hz ?? this.hz,
      connection: connection ?? this.connection,
      bearings: bearings ?? this.bearings,
      capacitor: capacitor ?? this.capacitor,
      springCaps: springCaps ?? this.springCaps,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! InductionMotor) return false;
    return other.springCaps == springCaps &&
        listEquals(other.poles, poles) &&
        listEquals(other.kw, kw) &&
        listEquals(other.hp, hp) &&
        listEquals(other.rpm, rpm) &&
        listEquals(other.volt, volt) &&
        listEquals(other.amps, amps) &&
        listEquals(other.hz, hz) &&
        listEquals(other.connection, connection) &&
        listEquals(other.bearings, bearings) &&
        listEquals(other.capacitor, capacitor) &&
        other.id == id &&
        other.brand == brand &&
        other.model == model &&
        other.phase == phase &&
        other.insulationClass == insulationClass &&
        other.weight == weight &&
        other.ambientTemperature == ambientTemperature &&
        other.ip == ip &&
        other.cosPhi == cosPhi;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      brand.hashCode ^
      model.hashCode ^
      phase.hashCode ^
      insulationClass.hashCode ^
      weight.hashCode ^
      ambientTemperature.hashCode ^
      ip.hashCode ^
      cosPhi.hashCode ^
      poles.hashCode ^
      kw.hashCode ^
      hp.hashCode ^
      rpm.hashCode ^
      volt.hashCode ^
      amps.hashCode ^
      hz.hashCode ^
      connection.hashCode ^
      bearings.hashCode ^
      capacitor.hashCode ^
      springCaps.hashCode;
}
