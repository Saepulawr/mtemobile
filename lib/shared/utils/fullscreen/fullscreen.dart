import 'package:flutter/services.dart';

void fullScreen({bool disable = false}) =>
    SystemChrome.setEnabledSystemUIOverlays(
        disable ? SystemUiOverlay.values : []);
