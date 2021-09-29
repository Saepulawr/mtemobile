import 'package:flutter/material.dart';
import 'package:mtemobile/config/const.dart';
import 'package:mtemobile/modules/barang_masuk/models/filter_model/filter_model.dart';
import 'package:mtemobile/modules/barang_masuk/models/filter_model/sort_model.dart';
import 'package:mtemobile/shared/themes/button.dart';
import 'package:mtemobile/shared/themes/theme.dart';

class FilterLayout extends StatefulWidget {
  final FilterModel currentFilter;
  final void Function(FilterModel resultFilter) onOK;
  FilterLayout({Key? key, required this.onOK, required this.currentFilter})
      : super(key: key);

  @override
  _FilterLayoutState createState() => _FilterLayoutState();
}

class _FilterLayoutState extends State<FilterLayout> {
  GlobalKey<FormState> _formKey = GlobalKey();
  late ValueNotifier<SortModel> _selectedSortingItems;
  late FilterModel _thisFilter;
  @override
  void initState() {
    super.initState();
    //default filter
    _thisFilter = FilterModel(
      sortBy: widget.currentFilter.sortBy ?? Const.sortingListItems[0],
      startDate: widget.currentFilter.startDate ??
          DateTime.now().subtract(Duration(days: 7)),
      endDate: widget.currentFilter.endDate ?? DateTime.now(),
    );
    _selectedSortingItems = ValueNotifier(_thisFilter.sortBy!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter",
            style: Themes.title,
          ),
          Divider(
            color: Colors.white,
          ),
          //urutkan
          _row(
            title: "Urutkan",
            content: ValueListenableBuilder<SortModel>(
              valueListenable: _selectedSortingItems,
              builder: (context, value, child) => Wrap(
                children: Const.sortingListItems
                    .map((e) => Container(
                        margin: EdgeInsets.only(right: 8.0),
                        child: primaryButton(
                            text: e.name!,
                            onPressed: () {
                              _selectedSortingItems.value = e;
                              _thisFilter = _thisFilter.copyWith(sortBy: e);
                            },
                            textColor: e.id! != value.id
                                ? Themes.primary
                                : Colors.white,
                            backgroundColor: e.id == value.id!
                                ? Themes.secondary
                                : Colors.white)
                        // ChoiceChip(

                        //   label: Text(
                        //     e,
                        //     style: Themes.primaryFont
                        //         .copyWith(color: Themes.primary),
                        //   ),
                        //   selected: value == e,
                        //   selectedColor: Themes.secondary.withOpacity(0.8),
                        //   onSelected: (value) {
                        //     _selectedSortingItems.value = e;
                        //   },
                        // ),
                        ))
                    .toList(),
              ),
            ),
          ),
          //tanggal awal
          _row(
            title: "Tanggal Awal",
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //start date
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _thisFilter.startDate!,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                    );
                    if (d != null) {
                      setState(() {
                        _thisFilter = _thisFilter.copyWith(startDate: d);
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text(Const.formatDate(_thisFilter.startDate!)),
                ),
              ],
            ),
          ),
          //tanggal awal
          _row(
            title: "Tanggal Akhir",
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //start date
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _thisFilter.endDate!,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                    );
                    if (d != null) {
                      setState(() {
                        _thisFilter = _thisFilter.copyWith(endDate: d);
                      });
                    }
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text(Const.formatDate(_thisFilter.endDate!)),
                ),
              ],
            ),
          ),
          //button ok
          FractionallySizedBox(
              widthFactor: 1.0,
              child: primaryButton(
                  text: "OK",
                  onPressed: () {
                    widget.onOK(_thisFilter);
                  },
                  backgroundColor: Themes.secondary,
                  elevation: 0.0)),
        ],
      ),
    );
  }

  Widget _row({Widget? icon, required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon == null
                ? Container()
                : Container(
                    width: 24,
                    height: 24,
                    margin: EdgeInsets.only(right: Themes.padding8),
                    alignment: Alignment.center,
                    child: icon),
            Text(
              title,
              style: Themes.primaryFont,
            ),
          ],
        ),
        //content
        content
      ],
    );
  }
}
