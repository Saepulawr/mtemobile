import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtelektrik/shared/themes/theme.dart';
import 'package:mtelektrik/shared/widgets/pull_to_refresh.dart/pull_to_resfreh.dart';
import 'package:mtelektrik/shared/widgets/textfield/search_textfield.dart';
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
      backgroundColor: Themes.background,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            titleSpacing: 0.0,
            title: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Themes.margin16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SearchTextField(
                        focus: false,
                        hintText: "Cari",
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  SizedBox(
                    width: Themes.margin16,
                  ),
                  TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () {},
                      icon: Icon(Icons.filter_list),
                      label: Text("Filter"))
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          pullToRefresh(onRefresh: () async {
            await Future.delayed(Duration(seconds: 3));
          }),
          SliverList(
              delegate: SliverChildListDelegate.fixed(List.generate(
                  20,
                  (index) => Container(
                        margin: EdgeInsets.symmetric(vertical: Themes.margin5),
                        child: ListTile(
                          onTap: () {},
                          leading: Image.asset("assets/images/pp.jpg"),
                          title: Text(index.toString()),
                        ),
                      ))))
        ],
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
