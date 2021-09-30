import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:get/get.dart';

class InputBarangMasukController extends GetxController {
  //TODO: controller for state management GetX
  var count =
      0.obs; //jadikan variable count menjadi observer dengan menambahkan .obs
  void increase() => count++;
}
