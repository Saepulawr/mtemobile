/*
PERHATIAN!!!
File ini dibuat secara otomatis oleh code-gen.dart   
Jika anda tidak mengerti isi dalam file ini, dimohon untuk
tidak mengubah apapun!,
terima kasih!.
*/

import 'dart:convert';

import 'package:dio/dio.dart';
//code-gen.dart - tolong jangan dihapus comment ini!

dynamic convertApiToModel<T>(Response response) {
  if (T is String) {
    return response.data.toString();
  } else if (T is Map) {
    return response.data;
  } else {
    switch (T) {

//code-gen.dart - tolong jangan dihapus comment ini!

      default:
        return null;
    }
  }
}
