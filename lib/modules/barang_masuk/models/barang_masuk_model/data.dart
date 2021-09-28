import 'barang_masuk.dart';

class Data {
  final int? maxPage;
  final List<BarangMasuk>? barangMasuk;
  const Data({
    this.maxPage,
    this.barangMasuk,
  });
  @override
  String toString() {
    return 'Data(maxPage: $maxPage, barangMasuk: $barangMasuk)';
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        maxPage: json['maxPage'] as int?,
        barangMasuk: (json['barangMasuk'] as List<dynamic>?)
            ?.map((e) => BarangMasuk.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => {
        'maxPage': maxPage,
        'barangMasuk': barangMasuk?.map((e) => e.toJson()).toList(),
      };
}
