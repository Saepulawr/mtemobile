import 'package:flutter/material.dart';
import 'package:mtemobile/shared/themes/theme.dart';

List<Widget> cardLoadingInfiniteScroll() {
  return List.generate(
      3,
      (index) => Themes.defaultShimmer(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Themes.radius10)),
            height: 120,
          )));
}
