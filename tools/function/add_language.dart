part of '../../code-gen.dart';

//======= ADD LANGUAGE =========================================================
Future<void> addLanguage() async {
  const String pathLangJson = "assets/language/id.json";
  final langJson = await readFile(pathLangJson);
  if (langJson == null) {
    printError("File Json Language tidak dapat di baca!");
    keluar();
  }
  String? langModel = await readFile(defaultPathLanguageModel);
  if (langModel == null) {
    printError("File Model Language tidak dapat di baca!");
    keluar();
  }
  printInfo("Tambah data language");
  final key =
      input("Masukan Nama Key \x1B[32m[Gunakan Spasi Pada Setiap Kata]\x1B[0m");
  if (key.isEmpty) {
    printError("Nama Key tidak dapat dikosongkan!");
    keluar();
  }
  //check key is exist
  Map<String, dynamic> dataLangJson = jsonDecode(langJson!);
  for (String k in dataLangJson.keys) {
    if (key.toCamelCase.trim() == k) {
      printError("Key yang anda masukan sudah ada!");
      addLanguage();
      return;
    }
  }
  final kalimat = input("Masukan Kalimat Translater");
  if (kalimat.isEmpty) {
    printError("Kalimat Translater tidak dapat dikosongkan!");
    keluar();
  }

  //insert data to json language
  final newDataJson =
      '    "${key.toCamelCase}": "${kalimat.replaceAll('"', '\\"')}",';
  await writeToFile(pathLangJson, "{\n$newDataJson" + langJson.split("{")[1]);
  //====insert data to language model=====
  await writeToDartFile(
      pathFile: defaultPathLanguageModel,
      code: [
        //init final
        "  final String? ${key.toCamelCase};",
        //init class
        "    this.${key.toCamelCase},",
        //from json
        "        ${key.toCamelCase}: json['${key.toCamelCase}'] as String?,"
      ],
      mode: ModeInsertToDartFile.afterTag);
  //tmp => _Key untuk splitternya dan _value untuk new datanya
  // Map<String, String> tmp = {
  //   "class LanguageModel {": "  final String? ${key.toCamelCase};",
  //   "  const LanguageModel({": "    this.${key.toCamelCase},",
  //   "  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(":
  //       "        ${key.toCamelCase}: json['${key.toCamelCase}'] as String?,"
  // };
  // tmp.forEach((_key, _value) {
  //   List<String> sp = langModel!.split(_key);
  //   langModel =
  //       (sp[0].isEmpty ? "" : sp[0] + "\n") + _key + "\n" + _value + sp[1];
  // });
  // await writeToFile(pathLangModel, langModel!);
}
