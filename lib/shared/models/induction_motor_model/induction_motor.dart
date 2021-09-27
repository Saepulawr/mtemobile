import '../capacitor_model/capacitor.dart';

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
  @override
  String toString() {
    return 'InductionMotor(id: $id, brand: $brand, model: $model, phase: $phase, insulationClass: $insulationClass, weight: $weight, ambientTemperature: $ambientTemperature, ip: $ip, cosPhi: $cosPhi, poles: $poles, kw: $kw, hp: $hp, rpm: $rpm, volt: $volt, amps: $amps, hz: $hz, connection: $connection, bearings: $bearings, capacitor: $capacitor, springCaps: $springCaps)';
  }

  factory InductionMotor.fromJson(Map<String, dynamic> json) => InductionMotor(
        id: json['id'] as String?,
        brand: json['brand'] as String?,
        model: json['model'] as String?,
        phase: json['phase'] as int?,
        insulationClass: json['insulationClass'] as String?,
        weight: json['weight'] as String?,
        ambientTemperature: json['ambientTemperature'] as String?,
        ip: json['ip'] as String?,
        cosPhi: json['cosPhi'] as String?,
        poles: json['poles'] as List<String>?,
        kw: json['kw'] as List<String>?,
        hp: json['hp'] as List<String>?,
        rpm: json['rpm'] as List<String>?,
        volt: json['volt'] as List<String>?,
        amps: json['amps'] as List<String>?,
        hz: json['hz'] as List<String>?,
        connection: json['connection'] as List<String>?,
        bearings: json['bearings'] as List<String>?,
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
        'ip': ip,
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
}
