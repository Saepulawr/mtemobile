/*
===========================================
Tools Code Generator
*****************************
dart run name-gen.dart help
*****************************
author  : saepulawr
email   : adm.ipul@gmail.com
github  : https://github.com/Saepulawr
===========================================
*/
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;

import 'tools/const/tag.dart';
import 'tools/plugins/recase.dart';
import 'tools/plugins/clippy/server.dart' as clipboard;
part 'tools/extension/string.dart';
part 'tools/const/path.dart';
part 'tools/function/public_function.dart';
part 'tools/function/add_module.dart';
part 'tools/function/add_language.dart';
part 'tools/function/add_api.dart';
part 'tools/function/add_model.dart';
part 'tools/data/init_data.dart';
part 'tools/help/public_help.dart';

const String packageName = "mtelektrik";
const String namaFile = "code-gen.dart";

void main(List<String> arguments) {
  if (arguments.isEmpty) printHelp();
  for (String opt in arguments) {
    switch (opt) {
      case "help":
        printHelp();
        break;
      case "add":
        if (arguments.length >= 2) {
          switch (arguments[1]) {
            case "module":
              addModule();
              break;
            case "language":
              addLanguage();
              break;
            case "api":
              addApi();
              break;
            case "model":
              addModel();
              break;
            default:
              printHelpAdd();
          }
        } else {
          //tidak ada argument selanjutnya
          printHelpAdd();
        }
        break;
      case "remove":
        if (arguments.length >= 2) {
          switch (arguments[1]) {
            case "module":
              removeModule();
              break;
            case "language":
              removeLanguage();
              break;
            default:
              printHelpRemove();
          }
        } else {
          //tidak ada argument selanjutnya
          printHelpRemove();
        }
        break;
    }
  }
}

//======= REMOVE LANGUAGE ======================================================
void removeLanguage() {}
//======= REMOVE MODULE ========================================================
void removeModule({String? moduleName}) {}
