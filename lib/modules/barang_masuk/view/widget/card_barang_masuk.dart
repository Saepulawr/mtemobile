import 'package:flutter/material.dart';
import 'package:mtemobile/config/const.dart';
import 'package:mtemobile/modules/barang_masuk/models/barang_masuk_model/barang_masuk.dart';
import 'package:mtemobile/shared/models/induction_motor_model/induction_motor.dart';
import 'package:mtemobile/shared/themes/theme.dart';
import 'package:mtemobile/shared/utils/animated/animated_scrolling.dart';
import 'package:mtemobile/shared/widgets/image/network_image.dart';
import 'package:mtemobile/shared/widgets/show_up_animation-2.0.0/show_up_animation.dart';

class CardBarangMasuk extends StatelessWidget {
  final BarangMasuk data;
  final double imageWidth;
  final double imageHeight;
  final EdgeInsets? margin;
  final void Function(BarangMasuk data)? onTap;
  final bool useAnimation;
  const CardBarangMasuk(
      {Key? key,
      required this.data,
      this.imageWidth = 120,
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
              color: Themes.primary,
              boxShadow: Themes.baseShadow(
                offset: Offset(0, 0),
              ),
              borderRadius: BorderRadius.all(Themes.radius10)),
          child: Row(
            children: [
              //image
              Expanded(
                child: Container(
                  constraints: BoxConstraints(minWidth: imageWidth),
                  child: NetworkImageLoader(
                    // width: imageWidth,
                    // height: imageHeight,
                    urlImage: data.image!,
                    borderRadius: BorderRadius.only(
                      topLeft: Themes.radius10,
                      bottomLeft: Themes.radius10,
                    ),
                    backgroundColor: Themes.primary,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                padding: const EdgeInsets.symmetric(
                  horizontal: Themes.padding12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //owner name
                    Padding(
                      padding: const EdgeInsets.only(top: Themes.padding8),
                      child: Text(
                        data.customer!.name!,
                        style: Themes.body,
                      ),
                    ),
                    //tanggal masuk
                    Padding(
                      padding: const EdgeInsets.only(top: Themes.padding5),
                      child: Text(
                        data.dateIn!,
                        style: Themes.caption
                            .copyWith(color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                    _buildMotorProperties(data.inductionMotor!)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildTable(String artLayout) {
  //   List<Widget> columns = [];
  //   List<String> rows = artLayout.split("\n");
  //   rows.forEach((row) {
  //     if (row.trim().isNotEmpty) {
  //       columns.add(Row(
  //         children: row
  //             .split("|")
  //             .map((e) => Container(
  //                 padding: EdgeInsets.all(3.0),
  //                 decoration: BoxDecoration(
  //                     border: Border(left: BorderSide(), bottom: BorderSide())),
  //                 child: Text(e.trim())))
  //             .toList(),
  //       ));
  //     }
  //   });
  //   print(columns.length);
  //   print('---------------------');

  //   return Column(
  //     children: columns,
  //   );
  // }
  Widget _row(
      {required Widget icon, required String title, String value = ""}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Themes.padding8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 24, height: 24, alignment: Alignment.center, child: icon),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Themes.primaryFont,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  value,
                  style: Themes.secondayFont,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMotorProperties(InductionMotor motor) {
    final double col1width = 130;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //brand
        Wrap(
          alignment: WrapAlignment.start,
          spacing: Themes.margin5,
          children: [
            SizedBox(
              width: col1width,
              child: _row(
                icon: Icon(
                  Icons.branding_watermark,
                  color: Colors.white,
                ),
                title: motor.brand!,
                value: motor.model!,
              ),
            ),
            if (motor.phase! == 3)
              //connection
              _row(
                icon: Icon(
                  Icons.link,
                  color: Colors.white,
                ),
                title: "Connection",
                value: motor.connection!.join("/"),
              ),
            if (motor.phase! == 1)
              // capacitor
              _row(
                icon: Icon(
                  Icons.settings_cell,
                  color: Colors.white,
                ),
                title: "Capacitor",
                value: motor.capacitor!
                    .map((e) => e.microFarad! + "uF " + e.volt! + "V")
                    .toList()
                    .join("\n"),
              ),
          ],
        ),
        //POWER AMPERE
        Wrap(
          alignment: WrapAlignment.start,
          spacing: Themes.margin5,
          children: [
            //POWER
            SizedBox(
              width: col1width,
              child: _row(
                icon: Icon(
                  Icons.power,
                  color: Colors.white,
                ),
                title: "Power " + motor.phase!.toString() + " Phase",
                value:
                    motor.kw!.join("/") + " HP, " + motor.hp!.join("/") + " KW",
              ),
            ),
            _row(
                icon: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: Text(
                    "A",
                    style: Themes.primaryFont.copyWith(
                        color: Themes.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                title: "Ampere",
                value: motor.amps!.join("/"))
          ],
        ),
        //VOLT HZ
        Wrap(
          alignment: WrapAlignment.start,
          spacing: Themes.margin5,
          children: [
            //VOLT
            SizedBox(
              width: col1width,
              child: _row(
                  icon: Icon(
                    Icons.bolt,
                    color: Colors.white,
                  ),
                  title: "Voltage",
                  value: motor.volt!.join("/")),
            ),
            _row(
                icon: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: Text(
                    "Hz",
                    style: Themes.primaryFont.copyWith(
                        color: Themes.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                title: "Frequency",
                value: motor.amps!.join("/"))
          ],
        ),
        //RPM Bearings
        Wrap(
          alignment: WrapAlignment.start,
          spacing: Themes.margin5,
          children: [
            //VOLT
            SizedBox(
              width: col1width,
              child: _row(
                  icon: Icon(
                    Icons.rotate_right,
                    color: Colors.white,
                  ),
                  title: "Rpm",
                  value: motor.rpm!.join("/")),
            ),
            //bearings
            _row(
                icon: Icon(
                  Icons.radio_button_checked,
                  color: Colors.white,
                ),
                title: "Bearings",
                value: motor.bearings!.join("\n")),
          ],
        ),
      ],
    );
  }
}
