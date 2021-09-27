/*
ERROR CODE DEFAULT
error code dan message harus ditentukan
class ini untuk internal error agar memudahkan developer untuk mencari pengebab error nya
dan untuk memberitahukan kepada user jika diperlukan
** semua message pada setiap error akan di translate kedalam bahasa yang telah dipilih
*/
import 'package:mtemobile/config/language.dart';

class ErrorCode {
  static ErrorCodeModel get networkConnectionTimeout => ErrorCodeModel(
      errorCode: 101, message: lang.networkErrorConnectionTimeout!);
  static ErrorCodeModel get networkSendTimeout =>
      ErrorCodeModel(errorCode: 102, message: lang.networkErrorSendTimeout!);
  static ErrorCodeModel get networkReceiveTimeout =>
      ErrorCodeModel(errorCode: 103, message: lang.networkErrorReceiveTimeout!);
  static ErrorCodeModel get networkServerError =>
      ErrorCodeModel(errorCode: 104, message: lang.networkErrorServer!);
  static ErrorCodeModel get networkConnectionCancel => ErrorCodeModel(
      errorCode: 105, message: lang.networkErrorConnectionCancel!);
  static ErrorCodeModel get networkInternalError =>
      ErrorCodeModel(errorCode: 106, message: lang.networkErrorInternal!);
}

class ErrorCodeModel {
  final int errorCode;
  final String message;
  final StackTrace? stackTrace;
  ErrorCodeModel(
      {required this.errorCode, required this.message, this.stackTrace});
}
