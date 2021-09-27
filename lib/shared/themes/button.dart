import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtemobile/shared/themes/theme.dart';

//ElevatedButton
Widget primaryButton({
  required String text,
  required void Function() onPressed,
  double fontSize = 14.0,
  EdgeInsets? padding,
  double elevation = 3,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: elevation,
      primary: Themes.primary,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10),
      ),
    ),
    child: Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: GoogleFonts.nunito(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
    ),
  );
}
