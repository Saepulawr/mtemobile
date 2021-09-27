import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mtemobile/shared/utils/api/utils/api_error_model.dart';
import 'package:mtemobile/shared/utils/error_handler/error_code.dart';

enum ApiErrorType {
  connectTimeout,
  sendTimeout,
  receiveTimeout,
  response,
  cancel,
  internalError,
  serverError,
}

class ApiErrorHandler {
  ApiErrorType errorType = ApiErrorType.internalError;
  ApiErrorModel? data;
  StackTrace? stackTrace;
  ApiErrorHandler({required dynamic rawData}) {
    if (rawData is DioError) {
      stackTrace = rawData.stackTrace;
      switch (rawData.type) {
        case DioErrorType.connectTimeout:
          this.errorType = ApiErrorType.connectTimeout;
          this.data = ApiErrorModel(
              errorCode: ErrorCode.networkConnectionTimeout.errorCode,
              message: ErrorCode.networkConnectionTimeout.message);
          break;
        case DioErrorType.sendTimeout:
          this.errorType = ApiErrorType.sendTimeout;
          this.data = ApiErrorModel(
              errorCode: ErrorCode.networkSendTimeout.errorCode,
              message: ErrorCode.networkSendTimeout.message);
          break;
        case DioErrorType.receiveTimeout:
          this.errorType = ApiErrorType.receiveTimeout;
          this.data = ApiErrorModel(
              errorCode: ErrorCode.networkReceiveTimeout.errorCode,
              message: ErrorCode.networkReceiveTimeout.message);
          break;
        case DioErrorType.response:
          //ini untuk spesifik error berdasarkan response code error nya
          // switch (this._dioError!.response!.statusCode){
          //   case 404:
          //   break;
          //   case 500:
          //   break;
          //   case .....
          // }
          try {
            //translate to api error model
            this.data = ApiErrorModel.fromJson(
                jsonDecode(rawData.response!.data)['error']);
            this.errorType = ApiErrorType.response;
          } catch (e) {
            //jika error tanpa response data atau response data tidak dapat di translate ke dalam api error model
            this.errorType = ApiErrorType.serverError;
            this.data = ApiErrorModel(
                errorCode: ErrorCode.networkServerError.errorCode,
                message: ErrorCode.networkServerError.message);
          }
          break;
        case DioErrorType.cancel:
          this.errorType = ApiErrorType.cancel;
          this.data = ApiErrorModel(
              errorCode: ErrorCode.networkConnectionCancel.errorCode,
              message: ErrorCode.networkConnectionCancel.message);
          break;
        case DioErrorType.other:
          this.errorType = ApiErrorType.internalError;
          this.data = ApiErrorModel(
              errorCode: ErrorCode.networkInternalError.errorCode,
              message: ErrorCode.networkInternalError.message);
          break;
      }
    } else {
      this.errorType = ApiErrorType.internalError;
      this.data = ApiErrorModel(
          errorCode: ErrorCode.networkInternalError.errorCode,
          message: ErrorCode.networkInternalError.message);
    }
  }
}
