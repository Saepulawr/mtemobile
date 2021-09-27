import 'package:flutter/cupertino.dart';

Widget pullToRefresh({Future<void> Function()? onRefresh}) {
  return CupertinoSliverRefreshControl(
      refreshTriggerPullDistance: 100.0,
      refreshIndicatorExtent: 30.0,
      onRefresh: onRefresh);
}
