import 'api_error_handler.dart';

class ApiResult<T> {
  bool isError = false;
  final ApiErrorHandler? error;
  final T? data;
  final rawData;
  ApiResult({required this.rawData, this.data, this.error}) {
    isError = this.error != null;
  }
}
