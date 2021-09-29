import 'package:mtemobile/modules/barang_masuk/models/filter_model/sort_model.dart';

class FilterModel {
  final SortModel? sortBy;
  final DateTime? startDate;
  final DateTime? endDate;
  FilterModel({this.sortBy, this.startDate, this.endDate});

  FilterModel copyWith({
    SortModel? sortBy,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return FilterModel(
      sortBy: sortBy ?? this.sortBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'sortBy': this.sortBy?.toJson(),
        'startDate': this.startDate.toString(),
        'endDate': this.endDate.toString()
      };
}
