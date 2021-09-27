import 'package:mtemobile/shared/themes/theme.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem>
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Flexible(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: isSelected && selectedIndex != 2
                        ? Themes.primaryLight
                        : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: IconTheme(
                  data: IconThemeData(
                      size: item.iconSize,
                      color: isSelected
                          ? (item.activeColorSecondary == null
                              ? item.activeColorPrimary
                              : item.activeColorSecondary)
                          : item.inactiveColorPrimary == null
                              ? item.activeColorPrimary
                              : item.inactiveColorPrimary),
                  child: item.icon,
                ),
              ),
            ),
          ),
          item.title == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      item.title ?? "",
                      style: TextStyle(
                          color: isSelected
                              ? (item.activeColorSecondary == null
                                  ? item.activeColorPrimary
                                  : item.activeColorSecondary)
                              : item.inactiveColorPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
