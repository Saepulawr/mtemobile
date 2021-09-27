import 'barang_masuk.dart';
class Data {
  final List<BarangMasuk>? barangMasuk;
  const Data({
    this.barangMasuk,
  });
  @override
  String toString() {
    return 'Data(barangMasuk: $barangMasuk)';
}  factory Data.fromJson(Map<String, dynamic> json) => Data(
        barangMasuk: (json['barangMasuk'] as List<dynamic>?)?.map((e) => BarangMasuk.fromJson(e as Map<String, dynamic>)).toList(),
      );
  Map<String, dynamic> toJson() => {
        'barangMasuk': barangMasuk?.map((e) => e.toJson()).toList(),
      };
}