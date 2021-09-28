import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:mtemobile/shared/themes/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mtemobile/shared/widgets/shadow/simple_shadow.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:mtemobile/shared/widgets/shadow/simple_shadow.dart';

class NetworkImageLoader extends StatelessWidget {
  final String urlImage;
  final double? width;
  final double? height;
  final Widget? onLoadingWidget;
  final Widget? onFailedWidget;
  final BorderRadius? borderRadius;
  final BoxFit? fit;
  final bool cache;
  final List<BoxShadow>? shadow;
  final Color? backgroundColor;
  NetworkImageLoader({
    Key? key,
    required this.urlImage,
    this.width,
    this.height,
    this.onLoadingWidget,
    this.onFailedWidget,
    this.borderRadius,
    this.fit,
    this.cache = true,
    this.shadow,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ExtendedImage.network(
    //   urlImage,
    //   width: width,
    //   height: height,
    //   fit: fit ?? BoxFit.cover,
    //   cache: cache,
    //   clearMemoryCacheIfFailed: true,
    //   clearMemoryCacheWhenDispose: true,
    //   enableMemoryCache: false,
    //   shape: BoxShape.rectangle,
    //   borderRadius: borderRadius,
    //   loadStateChanged: (ExtendedImageState state) {
    //     switch (state.extendedImageLoadState) {
    //       case LoadState.loading:
    //         return Container(
    //           height: height,
    //           width: width,
    //           padding: EdgeInsets.all(height! / 4),
    //           color: whiteColor,
    //           child: Image.asset(
    //             "assets/images/kadoin-icon.png",
    //             color: Colors.grey,
    //           ),
    //         );
    //         return defaultShimmer(
    //             child: Container(
    //                 height: height, width: width, color: Colors.white));

    //       ///if you don't want override completed widget
    //       ///please return null or state.completedWidget
    //       //return null;
    //       //return state.completedWidget;
    //       case LoadState.completed:
    //         // return state.completedWidget;
    //         return null;
    //       case LoadState.failed:
    //         return GestureDetector(
    //           child: onFailedWidget ??
    //               Container(
    //                   alignment: Alignment.center,
    //                   color: whiteColor,
    //                   height: height,
    //                   width: height,
    //                   padding: EdgeInsets.all(16),
    //                   child: FittedBox(
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Icon(
    //                             FontAwesome5.exclamation_triangle,
    //                             color: Colors.grey,
    //                             size: 35,
    //                           ),
    //                         ),
    //                         Text(
    //                           "Failed to load image",
    //                           style: poppinsBlackTextStyle.copyWith(
    //                               color: Colors.grey, fontSize: 14),
    //                         ),
    //                         Text(
    //                           "Click here to reload image!",
    //                           style: poppinsBlackTextStyle.copyWith(
    //                               color: Colors.grey, fontSize: 14),
    //                         )
    //                       ],
    //                     ),
    //                   )),
    //           onTap: () {
    //             state.reLoadImage();
    //           },
    //         );
    //     }
    //   },
    // );
    return CachedNetworkImage(
      imageUrl: urlImage,
      useOldImageOnUrlChange: false,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image:
              DecorationImage(fit: fit ?? BoxFit.cover, image: imageProvider),
          borderRadius: borderRadius,
        ),
      ),
      fit: fit ?? BoxFit.fill,
      placeholder: (context, url) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: backgroundColor ?? Colors.white,
              boxShadow: shadow),
          child: Image.asset(
            "assets/images/logo.png",
            // color: Colors.grey,
            fit: BoxFit.fitWidth,
          ),
        );
        // return Themes.defaultShimmer(
        //     child: Container(
        //   decoration:
        //       BoxDecoration(color: Colors.white, borderRadius: borderRadius),
        //   height: height,
        //   width: width,
        // ));
      },
      height: height,
      width: width,
      errorWidget: (context, url, error) =>
          onFailedWidget ??
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: backgroundColor ?? Colors.white),
              height: height,
              width: width,
              padding: EdgeInsets.all(16),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    // FontAwesome5.exclamation_triangle,
                    Icons.report_problem,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              )),
    );
  }
}
