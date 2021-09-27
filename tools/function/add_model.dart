part of '../../code-gen.dart';

Future<String> addModel({String namaModel = "", String namaModule = ""}) async {
  //-----FUNCTION-----------
  Future<bool> writeModel(
      Directory directory, String filename, Map<String, dynamic> data) async {
    Map<String, List<String>> dataWrite = {
      "import": [],
      "final": [],
      "init": [],
      "toString": [],
      "fromJson": [],
      "toJson": [],
    };
    String formatDataWrite(String _filename) {
      String _filenamePascal = _filename.toPascalCase;
      String data = dataWrite['import']!.join('\n');
      data += "\nclass $_filenamePascal {\n";
      data += dataWrite['final']!.join('\n');
      data += "\n  const $_filenamePascal({\n";
      data += dataWrite['init']!.join('\n');
      data += "\n  });\n";

      data +=
          "  @override\n  String toString() {\n    return '$_filenamePascal(${dataWrite['toString']!.join(', ')})';\n}";

      data +=
          "  factory $_filenamePascal.fromJson(Map<String, dynamic> json) => $_filenamePascal(\n";
      data += dataWrite['fromJson']!.join('\n');
      data += "\n      );\n";

      data += "  Map<String, dynamic> toJson() => {\n";
      data += dataWrite['toJson']!.join('\n');
      data += "\n      };\n}";

      return data;
    }

    String typeDataToString(dynamic _var) {
      if (_var is double) {
        return "double";
      } else if (_var is int) {
        return "int";
      } else if (_var is String) {
        return "String";
      } else if (_var is Object) {
        return "Object";
      } else {
        return "dynamic";
      }
    }

    void parseTypeVarToDataWrite(String key, dynamic value) {
      String keyCamelCase = key.toCamelCase;
      //tipe data integer
      if (value is int) {
        dataWrite["final"]!.add("  final int? $keyCamelCase;");
        dataWrite["init"]!.add("    this.$keyCamelCase,");
        dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
        dataWrite['fromJson']!
            .add("$keyCamelCase: json['$keyCamelCase'] as int?,");
        dataWrite['toJson']!.add("'$keyCamelCase': $keyCamelCase,");
      }
      //tipe data double
      else if (value is double) {
        dataWrite["final"]!.add("  final double? $keyCamelCase;");
        dataWrite["init"]!.add("    this.$keyCamelCase,");
        dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
        dataWrite['fromJson']!
            .add("$keyCamelCase: json['$keyCamelCase'] as double?,");
        dataWrite['toJson']!.add("'$keyCamelCase': $keyCamelCase,");
      }
      //tipe data bool
      else if (value is bool) {
        dataWrite["final"]!.add("  final bool? $keyCamelCase;");
        dataWrite["init"]!.add("    this.$keyCamelCase,");
        dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
        dataWrite['fromJson']!
            .add("$keyCamelCase: json['$keyCamelCase'] as bool?,");
        dataWrite['toJson']!.add("'$keyCamelCase': $keyCamelCase,");
      }
      //tipe data String
      else if (value is String) {
        dataWrite["final"]!.add("  final String? $keyCamelCase;");
        dataWrite["init"]!.add("    this.$keyCamelCase,");
        dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
        dataWrite['fromJson']!
            .add("$keyCamelCase: json['$keyCamelCase'] as String?,");
        dataWrite['toJson']!.add("'$keyCamelCase': $keyCamelCase,");
      }
      //tipe data null
      else if (value == null) {
        dataWrite["final"]!.add("  final dynamic $keyCamelCase;");
        dataWrite["init"]!.add("    this.$keyCamelCase,");
        dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
        dataWrite['fromJson']!.add("$keyCamelCase: json['$keyCamelCase'],");
        dataWrite['toJson']!.add("'$keyCamelCase': $keyCamelCase,");
      }
    }

    Future<void> parseTypeVarListToDataWrite(
        String key, List<dynamic> value) async {
      String keyCamelCase = key.toCamelCase;
      if (value.isEmpty) {
        //array kosong
        dataWrite["final"]!.add("  final List<dynamic>? $keyCamelCase;");
        dataWrite["init"]!.add("    this.$keyCamelCase,");
        dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
        dataWrite['fromJson']!
            .add("$keyCamelCase: json['$keyCamelCase'] as List<dynamic>?,");
        dataWrite['toJson']!.add("'$keyCamelCase': $keyCamelCase,");
      } else {
        //array tidak kosong
        if (value[0] is Map) {
          dataWrite['import']!.add("import '${key.toSnakeCase}.dart';");
          dataWrite["final"]!
              .add("  final List<${key.toPascalCase}>? $keyCamelCase;");
          dataWrite["init"]!.add("    this.$keyCamelCase,");
          dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
          dataWrite['fromJson']!.add(
              "        $keyCamelCase: (json['$keyCamelCase'] as List<dynamic>?)?.map((e) => ${key.toPascalCase}.fromJson(e as Map<String, dynamic>)).toList(),");
          dataWrite['toJson']!.add(
              "        '$keyCamelCase': $keyCamelCase?.map((e) => e.toJson()).toList(),");
          await writeModel(
              directory, key.toSnakeCase, value[0] as Map<String, dynamic>);
        } else if (value[0] is List) {
          await parseTypeVarListToDataWrite(key, value);
        } else {
          dataWrite["final"]!.add(
              "  final List<${typeDataToString(value[0])}>? $keyCamelCase;");
          dataWrite["init"]!.add("    this.$keyCamelCase,");
          dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
          dataWrite['fromJson']!.add(
              "$keyCamelCase: json['$keyCamelCase'] as List<${typeDataToString(value[0])}>?,");
          dataWrite['toJson']!.add("'$keyCamelCase': $keyCamelCase,");
        }
      }
    }

    await Future.forEach<String>(data.keys, (key) async {
      String keyCamelCase = key.toCamelCase;
      dynamic value = data[key];
      //tipe data Map/Object
      if (value is Map<String, dynamic>) {
        dataWrite['import']!.add("import '${key.toSnakeCase}.dart';");
        dataWrite["final"]!.add("  final ${key.toPascalCase}? $keyCamelCase;");
        dataWrite["init"]!.add("    this.$keyCamelCase,");
        dataWrite["toString"]!.add("$keyCamelCase: \$$keyCamelCase");
        dataWrite['fromJson']!.add(
            "        $keyCamelCase: json['$keyCamelCase'] == null ? null : ${key.toPascalCase}.fromJson(json['$keyCamelCase'] as Map<String, dynamic>),");
        dataWrite['toJson']!
            .add("        '$keyCamelCase': $keyCamelCase?.toJson(),");
        await writeModel(directory, key.toSnakeCase, value);
      }
      //type data List/Array
      else if (value is List) {
        await parseTypeVarListToDataWrite(key, value);
      } else {
        parseTypeVarToDataWrite(key, value);
      }
    });
    return await writeToFile(
        directory.path + "/" + filename.toSnakeCase + ".dart",
        formatDataWrite(filename));
  }

  //-----MAIN-----------
  const String title = "Tambah Model";
  printInfo(title);
  printInfo(
      "Salin 'Json response server' ke clipboard,lalu tekan 'Enter' untuk melanjutkan");
  input("");
  late Map<String, dynamic> data;
  //check clipboard
  try {
    data = jsonDecode(await clipboard.read());
  } catch (e) {
    printError(
        "Format pada clipboard anda salah!, harap salin text berformat 'Json'!");
    keluar();
  }

  //pilih module
  final modules = await getModules();
  late int indexModule;
  late String moduleName;
  if (namaModule.isEmpty) {
    indexModule = inputPilihan("Pilih Module", modules);
    moduleName = modules[indexModule - 1];
  } else {
    indexModule = -1;
    moduleName = namaModule;
  }

  //check dir
  final pathModel = defaultPathModuleModels(moduleName);
  if (!await dirExist(pathModel)) createDir(pathModel);
  late String modelName;
  if (namaModel.isEmpty) {
    final models = await getModels(moduleName);
    //check model exist
    bool modelNameAman = false;
    while (!modelNameAman) {
      modelName = input("Masukan nama model");
      if (modelName.trim().isEmpty) {
        printError("nama Model Tidak Boleh Kosong!");
        continue;
      } else {
        bool namamodelduplicate = false;
        for (String model in models) {
          if (model == (modelName + "_model").toSnakeCase) {
            printError("Nama Model Sudah Ada!");
            namamodelduplicate = true;
            continue;
          }
        }
        modelNameAman = !namamodelduplicate;
      }
    }
    modelName += " model";
  } else {
    modelName = namaModel;
  }

  //execute

  final pathFolderThisModel = pathModel + "/" + modelName.toSnakeCase;
  //create folder
  await createDir(pathFolderThisModel);
  await writeModel(Directory(pathFolderThisModel), modelName, data);

  //write to api converter
  await writeToDartFile(
      pathFile: defaultPathApiConverter,
      code: [
        //import
        "import 'package:$packageName/modules/${moduleName.toSnakeCase}/models/${modelName.toSnakeCase}/${modelName.toSnakeCase}.dart';",
        //convert
        "      case ${modelName.toPascalCase}:\n        return ${modelName.toPascalCase}.fromJson(jsonDecode(response.data));"
      ],
      mode: ModeInsertToDartFile.afterTag);
  printSuccess("Buat model sukses!");
  return modelName;
}
