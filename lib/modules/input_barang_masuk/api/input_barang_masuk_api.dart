import 'package:mtemobile/config/const.dart';
import 'package:mtemobile/modules/input_barang_masuk/models/data_search_customer_model/data_search_customer_model.dart';

import 'package:mtemobile/shared/utils/api/utils/api_endpoint.dart';
import 'package:mtemobile/shared/utils/api/utils/api_result.dart';
import 'package:mtemobile/shared/utils/api/utils/dio_handler.dart';

class InputBarangMasukApi {
  ApiEndpoint _apiEndpoint = ApiEndpoint();
  Future<ApiResult<DataSearchCustomerModel>> searchCustomer({
    required String searchQuery,
    int page = 1,
    int itemsPerpage = Const.itemsPerpage,
  }) async =>
      await DioHandler<DataSearchCustomerModel>().get(
        url: _apiEndpoint.inputBarangMasukSearchCustomerEndpoint,
        header: {/*TODO: Implement Header */},
        params: {
          "searchQuery": searchQuery,
          "page": page.toString(),
          "itemsPerpage": itemsPerpage.toString(),
        },
      );
}
