import '../models/barang_masuk_model/barang_masuk_model.dart';
import 'package:mtelektrik/shared/utils/api/utils/api_endpoint.dart';
import 'package:mtelektrik/shared/utils/api/utils/api_result.dart';
import 'package:mtelektrik/shared/utils/api/utils/dio_handler.dart';

class BarangMasukApi {
  ApiEndpoint _apiEndpoint = ApiEndpoint();
Future<ApiResult<BarangMasukModel>> get getDaftarBarangMasuk async =>
      await DioHandler<BarangMasukModel>().post(
        url: _apiEndpoint.barangMasukGetDaftarBarangMasukEndpoint,
        header: {/*TODO: Implement Header */},
        params: {/*TODO: Implement Params */},
        data: {/*TODO: Implement Data */},
      );

}
