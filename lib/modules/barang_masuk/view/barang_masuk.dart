import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtemobile/config/const.dart';
import 'package:mtemobile/modules/barang_masuk/view/widget/card_barang_masuk.dart';
import 'package:mtemobile/shared/themes/theme.dart';
import 'package:mtemobile/shared/widgets/card/card_infinite_scroll/card_loading_infinite_scroll.dart';
import 'package:mtemobile/shared/widgets/flutter_staggered_grid_view/src/widgets/staggered_tile.dart';
import 'package:mtemobile/shared/widgets/infinite_sliver_staggered_gridview.dart';
import 'package:mtemobile/shared/widgets/pull_to_refresh.dart/pull_to_resfreh.dart';
import 'package:mtemobile/shared/widgets/textfield/search_textfield.dart';
import '../controller/barang_masuk_controller.dart';

class BarangMasuk extends StatefulWidget {
  BarangMasuk({Key? key}) : super(key: key);

  @override
  _BarangMasukState createState() => _BarangMasukState();
}

class _BarangMasukState extends State<BarangMasuk>
    with AutomaticKeepAliveClientMixin<BarangMasuk> {
  BarangMasukController _barangMasukController = Get.find();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Themes.background,
      body: CustomScrollView(
        controller: _scrollController,
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
            await _barangMasukController.getListBarangMasuk(refresh: true);
          }),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Themes.padding16,
            ),
          ),
          GetBuilder<BarangMasukController>(
            id: "BarangMasuk",
            builder: (controller) {
              return InfiniteSliverStaggeredGridView(
                hasNext: !controller.isMaxData,
                nextData: () async => controller.getListBarangMasuk(),
                itemBuilder: (context, index) {
                  return CardBarangMasuk(
                      data: controller.listBarangMasuk[index]);
                },
                itemCount: controller.listBarangMasuk.length,
                crossAxisCount: 1,
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.fit(1);
                },
                controller: _scrollController,
                mainAxisSpacing: Themes.padding10,
                padding: EdgeInsets.only(
                  left: Const.baseMarginHorizontal,
                  right: Const.baseMarginHorizontal,
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
