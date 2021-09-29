import 'package:intl/intl.dart';
import 'package:mtemobile/modules/barang_masuk/models/filter_model/filter_model.dart';
import 'package:mtemobile/modules/barang_masuk/models/filter_model/sort_model.dart';

class Const {
  static const String productName = "mtemobile";
  //KEY LOCAL STORAGE

  //other
  static const double baseMarginHorizontal = 0.0;
  static List<SortModel> sortingListItems = [
    SortModel(id: "001", name: "Terbaru"),
    SortModel(id: "002", name: "Terlama"),
  ];
  static FilterModel defaultFilter = FilterModel(
    sortBy: sortingListItems[0],
    startDate: DateTime.now().subtract(Duration(days: 7)),
    endDate: DateTime.now(),
  );
  static String formatDate(DateTime date) =>
      DateFormat("dd/MM/yyyy").format(date);
}
