import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtemobile/shared/widgets/shimmer/shimmer.dart';

class Themes {
  Themes._();
  //Color
  static const Color primary = Color(0xff182243);
  static const Color primaryDark = Color(0xff047857);
  static const Color primaryLight = Color(0xffD1FAE5);
  static const Color secondary = Color(0xff00a4f1);
  static const Color black = Color(0xff1F2937);
  static const Color blackLight = Color(0xffF3F4F6);
  static const Color grey = Color(0xff8A8E95);
  static const Color redDanger = Color(0xffEF4444);
  static const Color blueOcean = Color(0xff3B82F6);
  static const Color yellowWarning = Color(0xffFBBF24);
  static const Color background = Color(0xffFAFAFF);
  static const Color lightGrey = Color(0xffFAFAFA);
  //border radius
  static Radius radius5 = Radius.circular(5);
  static Radius radius10 = Radius.circular(10);
  static Radius radius16 = Radius.circular(16);
  static Radius radius20 = Radius.circular(20);
  //padding
  static const double padding5 = 5.0;
  static const double padding8 = 8.0;
  static const double padding10 = 10.0;
  static const double padding12 = 12.0;
  static const double padding16 = 16.0;
  static const double padding20 = 20.0;
  static const double padding32 = 32.0;
  //Margin
  static const double margin5 = 5.0;
  static const double margin8 = 8.0;
  static const double margin10 = 10.0;
  static const double margin12 = 12.0;
  static const double margin16 = 16.0;
  static const double margin20 = 20.0;
  static const double margin32 = 32.0;
  //shadow
  static List<BoxShadow> baseShadow(
      {Offset? offset, double? blurRadius, Color? color}) {
    return [
      BoxShadow(
        offset: offset ?? Offset(0, 2),
        blurRadius: blurRadius ?? 6,
        spreadRadius: 0,
        color: color ?? Color(0xffCDCDCD).withOpacity(0.35),
      )
    ];
  }

  static List<BoxShadow> bottomBarShadow(
      {Offset? offset, double? blurRadius, Color? color}) {
    return [
      BoxShadow(
        offset: offset ?? Offset(0, -5),
        blurRadius: blurRadius ?? 10,
        spreadRadius: 0,
        color: color ?? Color(0xffF1F1FA).withOpacity(0.35),
      )
    ];
  }

  static List<BoxShadow> headerShadow(
      {Offset? offset, double? blurRadius, Color? color}) {
    return [
      BoxShadow(
        offset: offset ?? Offset(0, 4),
        blurRadius: blurRadius ?? 10,
        spreadRadius: 0,
        color: color ?? Color(0xffF1F1FA),
      )
    ];
  }

  static List<BoxShadow> cardShadow(
      {Offset? offset, double? blurRadius, Color? color}) {
    return [
      BoxShadow(
        offset: offset ?? Offset(0, 0),
        blurRadius: blurRadius ?? 10,
        spreadRadius: 0,
        color: color ?? Color(0xffE5E5E5).withOpacity(0.5),
      )
    ];
  }

  //font
  static TextStyle primaryFont = GoogleFonts.nunito(color: black);
  static TextStyle secondayFont = GoogleFonts.workSans(color: black);
  //Typography
  static TextStyle title = primaryFont.copyWith(
    fontSize: 16,
    letterSpacing: 0.2,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subtitle = primaryFont.copyWith(
    fontSize: 14,
    letterSpacing: 0.2,
    fontWeight: FontWeight.bold,
  );
  static TextStyle body = secondayFont.copyWith(
    fontSize: 12,
    letterSpacing: 0.0,
    fontWeight: FontWeight.w600,
  );
  static TextStyle caption = secondayFont.copyWith(
    fontSize: 12,
    letterSpacing: 0.0,
    fontWeight: FontWeight.w400,
  );
  //Theme
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(brightness: Brightness.dark),
    brightness: Brightness.dark,
    backgroundColor: background,
    accentColor: secondary,
    primaryColor: primary,
    textTheme: TextTheme(
      headline6: title,
      subtitle2: subtitle,
      bodyText1: body,
      bodyText2: body,
      caption: caption,
    ),
  );
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(brightness: Brightness.dark),
    brightness: Brightness.light,
    backgroundColor: background,
    accentColor: secondary,
    primaryColor: primary,
    textTheme: TextTheme(
      headline6: title,
      subtitle2: subtitle,
      bodyText1: body,
      bodyText2: body,
      caption: caption,
    ),
  );

  //other
  static Widget defaultShimmer({required Widget child}) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: child);
  }
}
