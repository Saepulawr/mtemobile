
class Capacitor {
  final String? microFarad;
  final String? volt;
  const Capacitor({
    this.microFarad,
    this.volt,
  });
  @override
  String toString() {
    return 'Capacitor(microFarad: $microFarad, volt: $volt)';
}  factory Capacitor.fromJson(Map<String, dynamic> json) => Capacitor(
microFarad: json['microFarad'] as String?,
volt: json['volt'] as String?,
      );
  Map<String, dynamic> toJson() => {
'microFarad': microFarad,
'volt': volt,
      };
}