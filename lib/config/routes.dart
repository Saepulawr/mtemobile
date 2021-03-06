/*
PERHATIAN!!!
File ini dibuat secara otomatis oleh code-gen.dart   
Jika anda tidak mengerti isi dalam file ini, dimohon untuk
tidak mengubah apapun!,
terima kasih!.
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtemobile/modules/splash_screen/view/splash_screen.dart';
import 'package:mtemobile/modules/main_layout/view/main_layout.dart';
import 'package:mtemobile/modules/barang_masuk/view/barang_masuk.dart';
import 'package:mtemobile/modules/input_barang_masuk/view/input_barang_masuk.dart';
//code-gen.dart - tolong jangan dihapus comment ini!
part 'routing_callback.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => SplashScreen(),
  '/main_layout': (context) => MainLayout(),
  '/barang_masuk': (context) => BarangMasuk(),
  '/input_barang_masuk': (context) => InputBarangMasuk(),
//code-gen.dart - tolong jangan dihapus comment ini!
};

class RoutesName {
  static List<String> _name = routes.keys.toList();
  static String get splashScreen => _name[0];
  static String get mainLayout => _name[1];
  static String get barangMasuk => _name[2];
  static String get inputBarangMasuk => _name[3];
//code-gen.dart - tolong jangan dihapus comment ini!
}
