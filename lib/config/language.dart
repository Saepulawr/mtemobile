import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mtelektrik/shared/utils/language/language_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mtelektrik/shared/widgets/easy_richtext/easy_rich_text.dart';
part '../shared/utils/language/language.dart';

extension LanguageUtils on String? {
  String langArgument({required List<String> args}) {
    String s = this ?? "";
    for (int index = 0; index < args.length; index++) {
      s = s.replaceAll("\$$index", args[index]);
    }
    return s;
  }

  Widget langArgumentToRichText(
      {required List<String> args,
      TextStyle? textStyle,
      List<TextStyle>? argsTextStyle,
      int maxlines = 2,
      bool softwrap = true,
      TextAlign? textAlign}) {
    //replace args
    String _formated = this.langArgument(args: args);

    //formating args
    List<EasyRichTextPattern> _patternList = [];
    for (int index = 0; index < args.length; index++) {
      TextStyle? _argTextStyle;
      if (argsTextStyle != null) {
        try {
          _argTextStyle = argsTextStyle[index];
        } catch (e) {}
      }
      _patternList.add(
          EasyRichTextPattern(targetString: args[index], style: _argTextStyle));
    }
    return EasyRichText(
      _formated,
      softWrap: softwrap,
      maxLines: maxlines,
      defaultStyle: textStyle,
      patternList: _patternList,
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

enum AvailableLanguage {
  english,
  indonesia,
}
late LanguageModel lang;
