import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:get/get.dart';
import 'package:mtemobile/modules/barang_masuk/api/barang_masuk_api.dart';
import 'package:mtemobile/modules/barang_masuk/models/barang_masuk_model/barang_masuk.dart';

class BarangMasukController extends GetxController {
  BarangMasukApi _barangMasukApi = BarangMasukApi();
  RxList<BarangMasuk> listBarangMasuk = RxList();
  int listBarangMasukPage = 1;
  bool isMaxData = false;
  Future<void> getListBarangMasuk(
      {bool refresh = false, String searchQuery = ""}) async {
    print("$refresh  $searchQuery $isMaxData $listBarangMasukPage");
    if (refresh) {
      listBarangMasukPage = 1;
      listBarangMasuk.clear();
      isMaxData = false;
      update(["BarangMasuk"]);
      return;
    }
    final result = await _barangMasukApi.getDaftarBarangMasuk(
        page: listBarangMasukPage, searchQuery: searchQuery);
    if (result.isError) {
      //error
      printError(info: result.error!.data!.message!);
    } else {
      listBarangMasuk.value.addAll(result.data!.data!.barangMasuk!);
      isMaxData = (listBarangMasukPage >= result.data!.data!.maxPage!);
      listBarangMasukPage++;
      update(["BarangMasuk"]);
    }
  }
}
