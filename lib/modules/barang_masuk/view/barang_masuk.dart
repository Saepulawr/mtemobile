import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import '../controller/barang_masuk_controller.dart';

class BarangMasuk extends StatefulWidget {
  BarangMasuk({Key? key}) : super(key: key);

  @override
  _BarangMasukState createState() => _BarangMasukState();
}

class _BarangMasukState extends State<BarangMasuk>
    with AutomaticKeepAliveClientMixin<BarangMasuk> {
  BarangMasukController _barangMasukController =
      Get.put(BarangMasukController());
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _barangMasukController.increase();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
