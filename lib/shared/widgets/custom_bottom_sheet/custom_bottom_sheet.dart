import 'package:flutter/material.dart';

class CustomBottomSheetController<T> {
  final BuildContext context;
  final bool isShowing;
  CustomBottomSheetController({required this.context, this.isShowing = true});
  void close([T? data]) {
    if (this.isShowing) {
      Navigator.of(this.context).pop(data);
    } else {
      throw "\x1B[31mCustom bottom sheet is closed, Please set 'tapOutSideToClose' to false\x1B[0m";
    }
  }
}

Future<T?> showCustomBottomSheet<T>({
  required BuildContext context,
  Widget Function(
          BuildContext context, CustomBottomSheetController<T> controller)?
      titleBuilder,
  Widget Function(
          BuildContext context,
          CustomBottomSheetController<T> controller,
          ScrollController scrollController)?
      contentBuilder,
  Widget Function(
          BuildContext context,
          CustomBottomSheetController<T> controller,
          ScrollController scrollController)?
      builder,
  bool tapOutsideToClose = true,
  void Function(CustomBottomSheetController<T> controller)? onTapOutside,
  double initialChildSize = 0.4,
  double minChildSize: 0.2,
  double maxChildSize: 0.75,
  BoxDecoration? boxDecoration,
  EdgeInsets? padding,
  EdgeInsets? margin,
}) async {
  CustomBottomSheetController<T> _controller =
      CustomBottomSheetController<T>(context: context, isShowing: true);
  return await showModalBottomSheet<T?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // useRootNavigator: true,
    builder: (context) {
      return GestureDetector(
        onTap: () async {
          //tap outside
          if (tapOutsideToClose) {
            _controller.close();
            _controller = CustomBottomSheetController<T>(
                context: context, isShowing: false);
          }
          if (onTapOutside != null) onTapOutside(_controller);
        },
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.001),
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: initialChildSize,
              minChildSize: minChildSize,
              maxChildSize: maxChildSize,
              builder: (_, controller) {
                return Container(
                  padding: padding,
                  margin: margin,
                  decoration: boxDecoration ??
                      BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                  child: builder != null
                      ? builder(context, _controller, controller)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 80,
                                child: const Divider(
                                  thickness: 5,
                                ),
                              ),
                            ),
                            //title
                            titleBuilder != null
                                ? titleBuilder(context, _controller)
                                : Container(),
                            //content
                            Expanded(
                                child: contentBuilder != null
                                    ? contentBuilder(
                                        context, _controller, controller)
                                    : Container()),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
