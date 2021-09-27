import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final void Function()? resumeCallBack;
  final void Function()? inactiveCallBack;
  final void Function()? pausedCallBack;
  final void Function()? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.inactiveCallBack,
    this.pausedCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) resumeCallBack!();
        break;
      case AppLifecycleState.inactive:
        if (inactiveCallBack != null) inactiveCallBack!();
        break;
      case AppLifecycleState.paused:
        if (pausedCallBack != null) pausedCallBack!();
        break;
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) suspendingCallBack!();

        break;
    }
  }
}
