import 'package:flutter/material.dart';

class CustomDialogController<T> {
  final BuildContext context;
  CustomDialogController(this.context);
  void pop(T? result) => Navigator.of(context).pop<T?>(result);
}

Future<T?> showCustomDialog<T>(
    {required BuildContext context,
    Color? backgroundColor,
    EdgeInsets? padding,
    required Widget builder(
      BuildContext context,
      CustomDialogController controller,
    )}) async {
  CustomDialogController _controller = CustomDialogController(context);
  return await showDialog<T>(
    useSafeArea: true,
    barrierDismissible: true,
    context: context,
    builder: (context) => SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      backgroundColor: backgroundColor,
      contentPadding: padding ?? EdgeInsets.all(16.0),
      titlePadding: EdgeInsets.zero,
      children: [builder(context, _controller)],
    ),
  );
}
