part of '../../code-gen.dart';

//======= FUNCTION =============================================================
enum ModeInsertToDartFile {
  beforeTag,
  afterTag,
}
Future<bool> writeToDartFile(
    {required pathFile,
    required List<String> code,
    ModeInsertToDartFile mode = ModeInsertToDartFile.beforeTag}) async {
  if (!await File(pathFile).exists()) return false;
  String rawData = (await readFile(pathFile))!;
  List<String> splittedString = rawData.split(tagSplitter);
  if (splittedString.length == 0) return false;
  for (int i = 0; i < splittedString.length - 1; i++) {
    if (mode == ModeInsertToDartFile.beforeTag) {
      splittedString[i] = code[i] + splittedString[i];
    } else {
      splittedString[i] = splittedString[i] + code[i];
    }
  }
  await writeToFile(pathFile, splittedString.join("\n$tagSplitter"));
  return true;
}

int inputPilihan(
  String title,
  List<String> pilihan,
) {
  int index = 0;
  String tmp = "";
  pilihan.forEach((element) {
    index++;
    tmp += "[$index] -> $element\n";
  });
  tmp = "[0] -> Keluar\n".toColorRed + tmp;
  String a = input("$title\n$tmp\nPilih 0-${pilihan.length}");
  try {
    int b = int.parse(a);
    if (b == 0) {
      keluar();
      return 0;
    } else if (b < 1 || b > pilihan.length) {
      printError("Jawaban anda tidak ada dalam daftar");
      return inputPilihan(title, pilihan);
    } else {
      return b;
    }
  } catch (e) {
    printError("Jawaban anda tidak ada dalam daftar");
    return inputPilihan(title, pilihan);
  }
}

Future<List<String>> getModules() async {
  final a = await dirContents(Directory(defaultPathModules))
      .map((event) => dirname(event.path, isPathFile: false))
      .toList();
  return a;
}

Future<List<String>> getModels(String moduleName) async {
  List<String> a = [];
  List<String> d =
      await dirContents(Directory(defaultPathModuleModels(moduleName)))
          .map((event) => event.path)
          .toList();
  await Future.forEach<String>(d, (pathModel) async {
    final dirName = dirname(pathModel, isPathFile: false);
    final dirIsExist = await dirExist(pathModel);
    if (dirName.endsWith("_model") && dirIsExist) a.add(dirName);
  });
  return a;
}

Stream<FileSystemEntity> dirContents(Directory dir) {
  return dir.list();
}

String dirname(String path, {bool isPathFile = true}) {
  if (isPathFile) {
    return path
        .replaceAll(translatePath("/${filename(path)}"), '')
        .split(translatePath("/"))
        .last;
  } else {
    return path.split(translatePath("/")).last;
  }
}

String filename(String path) {
  return path.split(translatePath("/")).last;
}

String safeRawDataModule(String rawData, String moduleName) {
  return rawData
      .replaceAll("@module@", moduleName.toSnakeCase.toLowerCase())
      .replaceAll("@MODULE@", moduleName.toPascalCase)
      .replaceAll("@packagename@", packageName)
      .replaceAll("@moduleCamelCase@", moduleName.toCamelCase);
}

String safeRawDataClass(String rawData, String className) {
  return rawData
      .replaceAll("@packagename@", packageName)
      .replaceAll("@ClassName@", className.toPascalCase);
}

String safeRawDataRequestApi(String rawData, String modelName,
    String requestName, String endpointNoHost) {
  return rawData
      .replaceAll(
          "@ModelName@",
          modelName.toLowerCase() == "dynamic"
              ? modelName.toLowerCase()
              : modelName.toPascalCase)
      .replaceAll("@requestName@", requestName.toCamelCase)
      .replaceAll("@endpointName@", endpointNoHost);
}

void printInfo(String text) {
  print(text.toColorCyan);
}

void printSuccess(String text) {
  print(text.toColorGreen);
}

void printWarning(String text) {
  print(text.toColorYellow);
}

void printError(String text) {
  print(text.toColorRed);
}

String input(String title) {
  stdout.writeln(title);
  final input = stdin.readLineSync();
  print("\n\n");
  return input!.trim();
}

bool inputYN(String title) {
  print(title);
  String t = "Jawab : [" + ("Y").toColorGreen + "/" + ("N").toColorRed + "]";
  final j = input(t);
  if (j.isEmpty) {
    return inputYN(title);
  } else {
    switch (j.trim().toUpperCase()) {
      case "Y":
        return true;
      case "N":
        return false;
      default:
        printError("Jawaban Anda Salah!");
        return inputYN(title);
    }
  }
}

void keluar({String pesan = ""}) {
  if (pesan.isEmpty) {
    printError("Perintah dibatalkan");
  }
  {
    printError(pesan);
  }
  exit(2);
}

Future<bool> dirExist(String path) async {
  return await Directory(translatePath(path)).exists();
}

Future<bool> writeToFile(String path, String contents) async {
  path = translatePath(path);
  try {
    await File(path).writeAsString(contents, flush: true);
    return true;
  } catch (e) {
    printError("ERROR : $e");
    return false;
  }
}

Future<String?> readFile(String path) async {
  path = translatePath(path);
  try {
    return await File(path).readAsString();
  } catch (e) {
    printError("ERROR : $e");
  }
}

Future<bool> createDir(String path, {bool recursive = false}) async {
  path = translatePath(path);
  try {
    await Directory(path).create(recursive: recursive);
    return true;
  } catch (e) {
    printError("ERROR : $e");
    return false;
  }
}
