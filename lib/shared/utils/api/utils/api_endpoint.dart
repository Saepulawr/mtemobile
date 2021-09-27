/*
PERHATIAN!!!
File ini dibuat secara otomatis oleh code-gen.dart   
Jika anda tidak mengerti isi dalam file ini, dimohon untuk
tidak mengubah apapun!,
terima kasih!.
*/

part 'package:mtelektrik/config/api.dart';

class ApiEndpoint {
  //host yang aktif dengan profile yang di pilih
  String _hostApi = "";
  ApiEndpoint({String? host}) {
    _hostApi = host ?? _hostAktif;
  }
  //code-gen.dart - tolong jangan dihapus comment ini!
  String get barangMasukGetDaftarBarangMasukEndpoint => _hostApi + "/mtemobile/api/barangmasuk/list";
}
