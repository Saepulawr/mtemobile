part of '../../code-gen.dart';

//======= ADD MODULE ===========================================================
Future<void> addModule({String namaModule = ""}) async {
  printInfo("Tambah module baru");
  namaModule = namaModule.isEmpty
      ? input(
          "Masukan Nama Module \x1B[32m[Gunakan Spasi Pada Setiap Kata]\x1B[0m")
      : namaModule;
  if (namaModule.isEmpty) keluar();
  final namaModuleFile = namaModule.replaceAll(" ", "_").toLowerCase();
  //check dir modules
  if (!await dirExist(defaultPathModules)) await createDir(defaultPathModules);
  String pathModuleBaru = "$defaultPathModules/$namaModuleFile";
  //check dir modules baru
  if (await dirExist(pathModuleBaru)) {
    //module sudah ada
    printWarning("Nama Module sudah ada!");
    addModule();
  } else {
    //buat folder module baru
    await createDir(pathModuleBaru);
    //buat folder api
    await createDir(defaultPathModuleApi(namaModuleFile));
    //buat folder controller
    await createDir(defaultPathModuleController(namaModuleFile));
    Map<String, dynamic> data = jsonDecode((await dataModule)!.toBase64Decode);
    //write controller file
    await writeToFile(
        defaultPathModuleController(namaModuleFile) +
            "/" +
            namaModuleFile +
            "_controller.dart",
        safeRawDataModule(
            (data["controller"] as String).toBase64Decode, namaModule));

    //buat folder models
    await createDir(defaultPathModuleModels(namaModuleFile));
    //buat folder view
    await createDir(defaultPathModuleView(namaModuleFile));
    //buat folder view layout
    await createDir(defaultPathModuleViewLayout(namaModuleFile));
    //buat folder view widget
    await createDir(defaultPathModuleViewWidget(namaModuleFile));
    //write file module
    await writeToFile(
        defaultPathModuleView(namaModuleFile) + "/$namaModuleFile.dart",
        safeRawDataModule((data["view"] as String).toBase64Decode, namaModule));

    //write to routes
    await writeToDartFile(
        pathFile: defaultPathRoutes,
        code: [
          //import
          "import 'package:$packageName/modules/${namaModule.toSnakeCase.toLowerCase()}/view/${namaModule.toSnakeCase.toLowerCase()}.dart';",
          //routes module
          "  '/${namaModule.toSnakeCase.toLowerCase()}': (context) => ${namaModule.toPascalCase}(),",
          //routes name
          "  static String get ${namaModule.toCamelCase} => _name[${(await getModules()).length - 1}];"
        ],
        mode: ModeInsertToDartFile.afterTag);
    printSuccess("Selesai buat module baru.");
  }
}
