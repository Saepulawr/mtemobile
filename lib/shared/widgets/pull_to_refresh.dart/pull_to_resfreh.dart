import 'package:flutter/cupertino.dart';

Widget pullToRefresh({Future<void> Function()? onRefresh}) {
  return CupertinoSliverRefreshControl(
      refreshTriggerPullDistance: 130.0,
      refreshIndicatorExtent: 30.0,
      onRefresh: onRefresh);
}
