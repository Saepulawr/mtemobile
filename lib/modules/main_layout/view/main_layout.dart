import 'package:flutter/material.dart';
import 'package:mtemobile/modules/barang_masuk/view/barang_masuk.dart';
import 'package:mtemobile/shared/themes/theme.dart';

class MainLayout extends StatefulWidget {
  MainLayout({Key? key}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<int> _tabIndex = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              BarangMasuk(),
              Center(
                child: Icon(Icons.home),
              ),
              Center(
                child: Icon(Icons.home),
              ),
              Center(
                child: Icon(Icons.home),
              )
            ]),
        backgroundColor: Themes.background,
        bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: _tabIndex,
            builder: (context, selectedIndex, child) => BottomNavigationBar(
                  backgroundColor: Themes.primary,
                  unselectedItemColor: Colors.white,
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    _tabController.animateTo(index);
                    _tabIndex.value = index;
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_downward),
                      label: "Barang Masuk",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.arrow_upward), label: "Barang Keluar"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.upload_file), label: "Surat Jalan"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.receipt), label: "Faktur")
                  ],
                )),
      ),
    );
  }
}
