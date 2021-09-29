import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:get/get.dart';
import 'package:mtemobile/modules/barang_masuk/api/barang_masuk_api.dart';
import 'package:mtemobile/modules/barang_masuk/models/barang_masuk_model/barang_masuk.dart';
import 'package:mtemobile/modules/barang_masuk/models/filter_model/filter_model.dart';

class BarangMasukController extends GetxController {
  BarangMasukApi _barangMasukApi = BarangMasukApi();
  RxList<BarangMasuk> listBarangMasuk = RxList();
  int listBarangMasukPage = 1;
  bool isMaxData = false;
  Future<void> getListBarangMasuk(
      {bool refresh = false,
      String searchQuery = "",
      FilterModel? filter}) async {
    if (refresh) {
      listBarangMasukPage = 1;
      isMaxData = false;
      listBarangMasuk.clear();
      update(["BarangMasuk"]);

      return;
    }
    print(listBarangMasukPage);
    final result = await _barangMasukApi.getDaftarBarangMasuk(
        page: listBarangMasukPage, searchQuery: searchQuery, filter: filter);

    if (result.isError) {
      //error
      printError(info: result.error!.data!.message!);
    } else {
      listBarangMasuk.addAll(result.data!.data!.barangMasuk!);
      isMaxData = (listBarangMasukPage >= result.data!.data!.maxPage!);
      listBarangMasukPage++;
      update(["BarangMasuk"]);
    }
  }
}
