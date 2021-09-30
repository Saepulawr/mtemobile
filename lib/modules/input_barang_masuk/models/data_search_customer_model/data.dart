import 'package:mtemobile/shared/models/customer_model/customer.dart';

class Data {
  final int? maxPage;
  final List<Customer>? customers;
  const Data({
    this.maxPage,
    this.customers,
  });
  @override
  String toString() {
    return 'Data(maxPage: $maxPage, customers: $customers)';
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        maxPage: json['maxPage'] as int?,
        customers: (json['customers'] as List<dynamic>?)
            ?.map((e) => Customer.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => {
        'maxPage': maxPage,
        'customers': customers?.map((e) => e.toJson()).toList(),
      };
}
