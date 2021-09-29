import 'package:flutter/material.dart';
import 'package:mtemobile/config/const.dart';
import 'package:mtemobile/modules/barang_masuk/models/filter_model/filter_model.dart';

import '../models/barang_masuk_model/barang_masuk_model.dart';
import 'package:mtemobile/shared/utils/api/utils/api_endpoint.dart';
import 'package:mtemobile/shared/utils/api/utils/api_result.dart';
import 'package:mtemobile/shared/utils/api/utils/dio_handler.dart';

class BarangMasukApi {
  ApiEndpoint _apiEndpoint = ApiEndpoint();
  Future<ApiResult<BarangMasukModel>> getDaftarBarangMasuk({
    required int page,
    String searchQuery = "",
    FilterModel? filter,
  }) async {
    if (filter == null) filter = Const.defaultFilter;
    return await DioHandler<BarangMasukModel>().post(
      url: _apiEndpoint.barangMasukGetDaftarBarangMasukEndpoint,
      header: {},
      params: {"page": page.toString(), "searchQuery": searchQuery},
      data: filter.toJson(),
    );
  }
}
