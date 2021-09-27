import 'package:flutter/material.dart';
import 'package:mtelektrik/shared/themes/theme.dart';

class CustomBottomBarBody {
  final Widget? customIcon;
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;
  final Widget? customSelectedIcon;
  final IconData? selectedIcon;
  final double selectedIconSize;
  final Color? selectedIconColor;
  final Widget body;
  final String badgeText;
  final bool useSelectedBackground;
  CustomBottomBarBody({
    this.useSelectedBackground = true,
    this.icon,
    this.selectedIcon,
    this.iconSize = 18,
    this.iconColor,
    this.customIcon,
    required this.body,
    this.badgeText = '',
    this.customSelectedIcon,
    this.selectedIconSize = 18,
    this.selectedIconColor,
  }) : assert(icon != null || customIcon != null,
            "Icon or Custom Icon cannot be null");
}

class CustomBottomBar extends StatefulWidget {
  final List<CustomBottomBarBody> children;
  final double height;
  final Color? iconColor;
  final Color? selectedIconColor;
  final Color? backgroundColor;
  final List<BoxShadow>? shadow;
  final BorderRadius? borderRadius;
  CustomBottomBar({
    Key? key,
    required this.children,
    this.height = 80,
    this.iconColor,
    this.selectedIconColor,
    this.backgroundColor,
    this.shadow,
    this.borderRadius,
  }) : super(key: key);
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.children.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: widget.children.map((e) => e.body).toList(),
            ),
          ),
          Positioned(bottom: 0, child: _buildBottomBar())
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton:
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: widget.height,
      padding: EdgeInsets.symmetric(vertical: Themes.padding20),
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: widget.borderRadius ??
              BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
          boxShadow: widget.shadow),
      width: MediaQuery.of(context).size.width,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, child) => SafeArea(
          top: false,
          child: TabBar(
            labelColor:
                widget.selectedIconColor ?? Theme.of(context).primaryColor,
            unselectedLabelColor: widget.iconColor ?? Colors.grey,
            labelStyle: TextStyle(fontSize: 10.0),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.transparent),
              // insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            ),
            //For Indicator Show and Customization
            // indicatorColor: Colors.black54,
            onTap: (index) {
              _selectedIndex.value = index;
            },
            tabs: _buildTabs(selectedIndex),

            controller: _tabController,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(int selectedIndex) {
    List<Widget> r = [];
    for (int i = 0; i < widget.children.length; i++) {
      final tab = widget.children[i];
      Widget icon = tab.customIcon != null
          ? tab.customIcon!
          : Icon(
              tab.icon,
              color: tab.iconColor ?? widget.iconColor,
              size: tab.iconSize,
            );
      Widget selectedIcon = tab.customSelectedIcon != null
          ? tab.customSelectedIcon!
          : tab.selectedIcon != null
              ? Icon(
                  tab.selectedIcon,
                  color: tab.selectedIconColor ?? widget.selectedIconColor,
                  size: tab.selectedIconSize,
                )
              : icon;

      r.add(Stack(
        alignment: Alignment.center,
        children: [
          tab.useSelectedBackground && i == selectedIndex
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Themes.primaryLight,
                      borderRadius: BorderRadius.all(Themes.radius5)),
                )
              : SizedBox(),
          i == selectedIndex ? selectedIcon : icon,
        ],
      ));
    }
    return r;
  }
}
