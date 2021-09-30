import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtemobile/config/const.dart';
import 'package:mtemobile/config/routes.dart';
import 'package:mtemobile/modules/barang_masuk/models/filter_model/filter_model.dart';
import 'package:mtemobile/modules/barang_masuk/view/layout/filter_layout.dart';
import 'package:mtemobile/modules/barang_masuk/view/widget/card_barang_masuk.dart';
import 'package:mtemobile/shared/themes/button.dart';
import 'package:mtemobile/shared/themes/theme.dart';
import 'package:mtemobile/shared/widgets/customDialog/custom_dialog.dart';
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
  // BarangMasukController _barangMasukController = Get.find();
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();
  late FilterModel _filter;
  @override
  void initState() {
    super.initState();
    _filter = Const.defaultFilter;
  }

  Future<void> _refresh(BarangMasukController controller) async {
    //refresh ini hanya clear data yg di simpan,dan untuk get data kembali,aksinya dilakukan widget infinitescroll
    await controller.getListBarangMasuk(
        refresh: true,
        searchQuery: _textEditingController.text,
        filter: _filter);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<BarangMasukController>(
        id: "BarangMasuk",
        builder: (controller) {
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
                      horizontal: Themes.margin8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchTextField(
                            controller: _textEditingController,
                            focus: false,
                            hintText: "Cari",
                            onTextReset: () async => await _refresh(controller),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onEditingComplete: (query) async {
                              await _refresh(controller);
                            },
                          ),
                        ),
                        SizedBox(
                          width: Themes.margin16,
                        ),
                        TextButton.icon(
                            style: TextButton.styleFrom(primary: Colors.white),
                            onPressed: () async {
                              final resultFilter =
                                  await showCustomDialog<FilterModel>(
                                context: context,
                                backgroundColor: Themes.primary,
                                builder: (context, controller) => FilterLayout(
                                  currentFilter: _filter,
                                  onOK: (value) => controller.pop(value),
                                ),
                              );
                              if (resultFilter != null) {
                                _filter = resultFilter;
                                await _refresh(controller);
                              }
                            },
                            icon: Icon(Icons.filter_list),
                            label: Text("Filter")),
                      ],
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
                pullToRefresh(
                  onRefresh: () async => await _refresh(controller),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Themes.padding16,
                  ),
                ),
                InfiniteSliverStaggeredGridView(
                  hasNext: !controller.isMaxData,
                  nextData: () async {
                    await controller.getListBarangMasuk(
                        searchQuery: _textEditingController.text,
                        filter: _filter);
                  },
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
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed(RoutesName.inputBarangMasuk);
                return;
                showCustomDialog(
                  context: context,
                  backgroundColor: Themes.primary,
                  builder: (context, controller) {
                    return Column(
                      children: [
                        Icon(
                          Icons.help,
                          color: Colors.white,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Ada surat jalan?"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            primaryButton(
                                elevation: 0.0,
                                backgroundColor: Colors.green,
                                text: "Ada",
                                onPressed: () {}),
                            SizedBox(
                              width: 16.0,
                            ),
                            primaryButton(
                                elevation: 0.0,
                                backgroundColor: Colors.red,
                                text: "Ga ada",
                                onPressed: () {})
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
