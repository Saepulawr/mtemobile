import 'package:flutter/material.dart';
import 'package:mtemobile/shared/widgets/show_up_animation-2.0.0/show_up_animation.dart';

Widget animatedScolling(
    {required Widget child,
    required Direction direction,
    Curve curve = Curves.linear,
    bool reverse = false}) {
  return ShowUpAnimation(
      animationDuration: Duration(milliseconds: 500),
      curve: curve,
      direction: direction,
      offset: reverse ? -0.5 : 0.5,
      child: child);
}
