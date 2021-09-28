import 'package:flutter/material.dart';

import '../models/barang_masuk_model/barang_masuk_model.dart';
import 'package:mtemobile/shared/utils/api/utils/api_endpoint.dart';
import 'package:mtemobile/shared/utils/api/utils/api_result.dart';
import 'package:mtemobile/shared/utils/api/utils/dio_handler.dart';

class BarangMasukApi {
  ApiEndpoint _apiEndpoint = ApiEndpoint();
  Future<ApiResult<BarangMasukModel>> getDaftarBarangMasuk({
    required int page,
    String searchQuery = "",
  }) async =>
      await DioHandler<BarangMasukModel>().post(
        url: _apiEndpoint.barangMasukGetDaftarBarangMasukEndpoint,
        header: {},
        params: {"page": page.toString(), "searchQuery": searchQuery},
        data: {},
      );
}
