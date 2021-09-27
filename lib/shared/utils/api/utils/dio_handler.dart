import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mtemobile/shared/utils/api/utils/api_error_handler.dart';
import 'package:mtemobile/shared/utils/api/utils/api_result.dart';
import 'package:path/path.dart';

import 'api_converter.dart';

//code-gen.dart - tolong jangan dihapus comment ini!
class DioHandler<T> {
  late Dio _dio;
  DioHandler({BaseOptions? options}) {
    _dio = Dio(options != null
        ? options.copyWith(
            //untuk anggap response code > 200 tidak error
            // validateStatus: (status) => status! < 500
            )
        : BaseOptions(
            connectTimeout: 30000, //30 detik
            receiveTimeout: 30000, //30 detik
            //untuk anggap response code > 200 tidak error
            // validateStatus: (status) => status! < 500,
          ));
  }
  Future<ApiResult<T>> put(
      {required String url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? params,
      required dynamic data,
      bool sendDataAsForm = false,
      onSendProgress(int sent, int total)?,
      onReceiveProgress(int receive, int total)?}) async {
    try {
      Response response = await _dio.put(url,
          queryParameters: params ?? {},
          data: sendDataAsForm ? FormData.fromMap(data) : data,
          options: Options(
              headers: header ?? {},
              responseType: ResponseType.json,
              contentType: sendDataAsForm ? "" : "application/json"),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return ApiResult<T>(
          rawData: response.data, data: convertApiToModel<T>(response));
    } on DioError catch (e) {
      return ApiResult(rawData: e, error: ApiErrorHandler(rawData: e));
    }
  }

  Future<ApiResult<T>> post(
      {required String url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? params,
      required dynamic data,
      bool sendDataAsForm = false,
      onSendProgress(int sent, int total)?,
      onReceiveProgress(int receive, int total)?}) async {
    try {
      if (kDebugMode) print(data);
      Response response = await _dio.post(url,
          queryParameters: params ?? {},
          data: sendDataAsForm ? FormData.fromMap(data) : data,
          options: Options(
              headers: header ?? {},
              responseType: ResponseType.json,
              contentType: sendDataAsForm ? "" : "application/json"),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return ApiResult<T>(
          rawData: response.data, data: convertApiToModel<T>(response));
    } on DioError catch (e) {
      return ApiResult(rawData: e, error: ApiErrorHandler(rawData: e));
    }
  }

  Future<ApiResult<T>> get(
      {required String url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? params,
      onReceiveProgress(int receive, int total)?}) async {
    try {
      Response response = await _dio.get(url,
          queryParameters: params ?? {},
          options: Options(
            headers: header ?? {},
            responseType: ResponseType.json,
          ),
          onReceiveProgress: onReceiveProgress);

      return ApiResult<T>(
          rawData: response.data, data: convertApiToModel<T>(response));
    } on DioError catch (e) {
      return ApiResult(rawData: e, error: ApiErrorHandler(rawData: e));
    }
  }

  Future<ApiResult<T>> delete({
    required String url,
    Map<String, dynamic>? header,
    Map<String, dynamic>? params,
  }) async {
    try {
      Response response = await _dio.delete(url,
          queryParameters: params ?? {},
          options: Options(
            headers: header ?? {},
            responseType: ResponseType.json,
          ));

      return ApiResult<T>(
          rawData: response.data, data: convertApiToModel<T>(response));
    } on DioError catch (e) {
      return ApiResult(rawData: e, error: ApiErrorHandler(rawData: e));
    }
  }

  Future<ApiResult<T>> uploads(
      {required String url,
      required List<DioFileUploads> files,
      Map<String, String>? header,
      Map<String, dynamic>? params,
      required Map<String, dynamic> data,
      onSendProgress(int send, int total)?,
      onReceiveProgress(int receive, int total)?}) async {
    FormData formData = FormData.fromMap(data);
    files.forEach((element) async {
      formData.files.add(MapEntry(
          element.key,
          await MultipartFile.fromFile(element.pathFile,
              filename: basename(element.pathFile))));
    });
    try {
      Response response = await _dio.post(url,
          queryParameters: params ?? {},
          data: formData,
          options: Options(headers: header, responseType: ResponseType.json),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return ApiResult<T>(
          rawData: response.data, data: convertApiToModel<T>(response));
    } on DioError catch (e) {
      return ApiResult(rawData: e, error: ApiErrorHandler(rawData: e));
    }
  }

  Future<void> download(
      {required String url,
      Map<String, String>? header,
      Map<String, dynamic>? params,
      required String savePath,
      onDownloadComplete(File downloadedFile)?,
      onError(Object error)?,
      onReceiveProgress(int receive, int total)?}) async {
    try {
      Response response = await _dio.get(url,
          queryParameters: params ?? {},
          options: Options(
            headers: header ?? {},
            responseType: ResponseType.bytes,
            followRedirects: false,
          ),
          onReceiveProgress: onReceiveProgress);

      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      if (onDownloadComplete != null) onDownloadComplete(file);
    } catch (e) {
      if (onError != null) onError(e);
    }
  }
}

class DioFileUploads {
  final String key;
  final String pathFile;
  DioFileUploads({
    required this.key,
    required this.pathFile,
  });
}
