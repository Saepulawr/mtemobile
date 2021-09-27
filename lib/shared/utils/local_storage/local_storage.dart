import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

///[LocalStorage]
class LocalStorage<T> {
  static SharedPreferences? _prefs;
  static Future<void> init() async {
    //init di panggil cukup satu kali,
    await Hive.initFlutter();
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  T load(String key) {
    if (T == String) {
      return _prefs!.getString(key) as T? ?? "" as T;
    } else if (T == bool) {
      return _prefs!.getBool(key) as T? ?? false as T;
    } else if (T == double) {
      return _prefs!.getDouble(key) as T? ?? 0.0 as T;
    } else if (T == int) {
      return _prefs!.getInt(key) as T? ?? 0 as T;
    } else {
      ///as list karna ga bisa di comparre T is List atau T as List<blabla>
      List<String> r = _prefs!.getStringList(key) ?? [];
      return r.map((e) => e.toString()).toList() as T? ?? [] as T;
    }
  }

  Future<bool> save(String key, T value) async {
    if (T == String) {
      return await _prefs!.setString(key, value as String);
    } else if (T == bool) {
      return _prefs!.setBool(key, value as bool);
    } else if (T == double) {
      return _prefs!.setDouble(key, value as double);
    } else if (T == int) {
      return _prefs!.setInt(key, value as int);
    } else {
      //as list karna ga bisa di comparre T is List atau T as List<blabla>
      return await _prefs!.setStringList(key, value as List<String>);
    }
  }

  Map<String, dynamic> loadJson(String key) {
    try {
      final data = LocalStorage<String>().load("%json%" + key);
      return jsonDecode(data.isEmpty ? "{}" : data);
    } catch (e) {
      return {};
    }
  }

  Future<bool> saveJson(String key, Map<String, dynamic> object) async {
    return await LocalStorage<String>()
        .save("%json%" + key, jsonEncode(object));
  }

  // ///[loadModel] untuk load model, dalam object model harus terdapat function *.fromJson(json);
  // T? loadModel(String key) {
  //   try {
  //     dynamic object = T;
  //     object.fromJson(jsonDecode(LocalStorage<String>().load("%model%" + key)));
  //   } catch (e) {}
  // }

  // ///[saveModel] untuk save model, dalam object model harus terdapat function *.toJson();
  // Future<bool> saveModel(String key, dynamic model) async {
  //   try {
  //     return await saveJson(key, model.toJson());
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
