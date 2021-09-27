import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtelektrik/config/const.dart';
import 'package:mtelektrik/shared/themes/theme.dart';
import 'package:mtelektrik/shared/utils/animated/animated_scrolling.dart';
import 'package:mtelektrik/shared/widgets/card/card_infinite_scroll/models/data.dart';
import 'package:mtelektrik/shared/widgets/custom_progressbar/custom_progressbar.dart';
import 'package:mtelektrik/shared/widgets/image/network_image.dart';
import 'package:mtelektrik/shared/widgets/show_up_animation-2.0.0/show_up_animation.dart';

class CardInfiniteScroll extends StatelessWidget {
  final DataCardInfiniteScroll data;
  final double imageWidth;
  final double imageHeight;
  final EdgeInsets? margin;
  final void Function(DataCardInfiniteScroll data)? onTap;
  final bool useAnimation;
  const CardInfiniteScroll(
      {Key? key,
      required this.data,
      this.imageWidth = 130,
      this.imageHeight = 120,
      this.margin,
      this.onTap,
      this.useAnimation = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useAnimation
        ? animatedScolling(
            direction: Direction.vertical, child: _buildContent(context))
        : _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    double maxContentWidth = MediaQuery.of(context).size.width -
        imageWidth -
        (Const.baseMarginHorizontal * 2) -
        (Themes.padding12 * 2);
    return GestureDetector(
      onTap: () {
        if (this.onTap != null) this.onTap!(data);
      },
      child: IntrinsicHeight(
        child: Container(
          margin: margin ?? EdgeInsets.symmetric(horizontal: Themes.margin10),
          constraints: BoxConstraints(minHeight: imageHeight),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: Themes.baseShadow(
                offset: Offset(0, 0),
              ),
              borderRadius: BorderRadius.all(Themes.radius10)),
          child: Row(
            children: [
              //image
              NetworkImageLoader(
                width: imageWidth,
                urlImage: data.image!,
                borderRadius: BorderRadius.only(
                    topLeft: Themes.radius10,
                    bottomLeft: Themes.radius10,
                    topRight: Themes.radius10,
                    bottomRight: Themes.radius10),
              ),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Themes.padding12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      Padding(
                        padding: const EdgeInsets.only(top: Themes.padding8),
                        child: Text(
                          data.title!,
                          style: Themes.body,
                        ),
                      ),
                      //organizer name
                      Padding(
                        padding: const EdgeInsets.only(top: Themes.padding5),
                        child: Text(
                          data.organizerName!,
                          style: Themes.caption.copyWith(color: Themes.grey),
                        ),
                      ),
                      //lokasi
                      Padding(
                        padding: const EdgeInsets.only(top: Themes.padding16),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/svg/Location Icon.svg",
                              color: Themes.yellowWarning,
                              height: 12,
                              width: 12,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: Themes.padding10),
                                child: Text(
                                  data.organizerName!,
                                  style: Themes.caption,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Jadwal
                      Padding(
                        padding: const EdgeInsets.only(top: Themes.padding10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/svg/Calender Icon.svg",
                              color: Themes.yellowWarning,
                              height: 12,
                              width: 12,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: Themes.padding10),
                                child: Text(
                                  data.dateTime!,
                                  style: Themes.caption,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //quota
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Themes.padding16, bottom: Themes.padding12),
                        child: ProgressBar(
                            valueColor: Themes.primary,
                            backgroundColor: Color(0xffF3F4F6),
                            borderColor: Colors.transparent,
                            value: data.joinedParticipant!.toDouble(),
                            maxValue: data.quota!.toDouble()),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
