part of '../../code-gen.dart';

//======= ADD API ==============================================================
Future<void> addApi() async {
  const String title = "Tambah API Function";
  printInfo(title);
  Map<String, String> summary = {
    "Module": "",
    "Model": "",
    "Method": "",
    "Endpoint": "",
    "Request Name": ""
  };
  List<String> summaryList() {
    return summary.keys.map((e) => e + " : " + summary[e]!).toList();
  }

  void printSummary() {
    print("--------------------------------");
    summaryList().forEach((element) {
      print(element);
    });
    print("--------------------------------");
  }

  final modules = await getModules();
  late List<String> models = [];
  final method = ["GET", "POST", "PUT", "DELETE"];

  late int indexModulePilihan;
  late String moduleNamePilihan;
  late int indexModelPilihan;
  late String modelNamePilihan;
  late int indexMethodPilihan;
  late String methodNamePilihan;
  late String endpoint;
  late Uri endPointUri;
  late String requestName;
  const String hostAlias = "{{base_url}}";
  const String hostSample = "https://host.com";
  Future<void> processInput(int _step) async {
    switch (_step) {
      case 1:
        //pilih module
        indexModulePilihan = inputPilihan("Pilih Module", modules);
        moduleNamePilihan = modules[indexModulePilihan - 1];
        summary["Module"] = moduleNamePilihan;
        summary["Model"] = "";
        modelNamePilihan = "";
        printInfo(title);
        printSummary();
        break;
      case 2:
        //pilih model
        models = await getModels(moduleNamePilihan);
        if (models.isEmpty) {
          //tidak memiliki model
          bool buatModelBaru = inputYN(
              "Module '$moduleNamePilihan' tidak memiliki model, Tambahkan Model Baru?");
          if (buatModelBaru) {
            indexModelPilihan = -1;
            modelNamePilihan = await addModel(namaModule: moduleNamePilihan);
            modelNamePilihan = modelNamePilihan.toSnakeCase;
          } else {
            //tidak dibuatkan model
            modelNamePilihan = "";
          }
        } else {
          models.add("Tambah Baru".toColorGreen);
          models.add("Tidak Pakai Model".toColorMagenta);
          indexModelPilihan = inputPilihan("Pilih Model", models);
          if (indexModelPilihan == models.length - 1) {
            //tambah model baru
            indexModelPilihan = -1;
            modelNamePilihan = await addModel(namaModule: moduleNamePilihan);
            modelNamePilihan = modelNamePilihan.toSnakeCase;
          } else if (indexModelPilihan == models.length) {
            //tidak pakai model
            indexModelPilihan = -1;
            modelNamePilihan = "";
          } else {
            modelNamePilihan = models[indexModelPilihan - 1].toSnakeCase;
          }
        }
        summary["Model"] = modelNamePilihan;
        printInfo(title);
        printSummary();
        break;
      case 3:
        //pilih method
        indexMethodPilihan = inputPilihan("Pilih Method", method);
        methodNamePilihan = method[indexMethodPilihan - 1];
        summary["Method"] = methodNamePilihan;
        printInfo(title);
        printSummary();
        break;
      case 4:
        //isi endpoint
        await Future.doWhile(() {
          endpoint = input(
              "Masukan Endpoint api berikut dengan hostnya\nEx: $hostSample/foo/endpoint atau $hostAlias/foo/endpoint");
          if (endpoint.startsWith(hostAlias))
            endpoint = endpoint.replaceAll(hostAlias, hostSample);
          try {
            endPointUri = Uri.parse(endpoint);
            endpoint = endPointUri.origin + endPointUri.path;
            return false;
          } catch (e) {
            printError("Format yg anda masukan salah!");
            return true;
          }
        });

        summary["Endpoint"] = endpoint.replaceAll(hostSample, hostAlias);

        printInfo(title);
        printSummary();
        break;
      case 5:
        //isi endpoint
        requestName = input("Masukan Request Name \nEx: get daftar siswa");
        summary["Request Name"] = requestName.toCamelCase;
        // printInfo(title);
        // printSummary();
        break;
      default:
    }
  }

  //--main------
  for (int step = 1; step < 6; step++) {
    await processInput(step);
  }
  //summary
  bool dataSudahOK = false;
  while (!dataSudahOK) {
    printInfo("Ubah Data ?");
    List<String> data =
        summary.keys.map((e) => e + " : " + summary[e]!).toList();
    data.add("Data Sudah OK".toColorGreen);
    final j = inputPilihan("", data);
    if (j == data.length) {
      dataSudahOK = true;
    } else if (j == 1) {
      //jika  pilih ubah module,maka model juga harus di pilih
      await processInput(1);
      await processInput(2);
    } else {
      printInfo("Ubah Data");
      await processInput(j);
    }
  }

  //----------------execute
  //buat file api pada module yang di pilih
  File fileApi = File(defaultPathModuleApi(summary['Module']!) +
      "/" +
      summary['Module']! +
      "_api.dart");
  String className = (summary['Module']! + "_api").toPascalCase;
  //cek folder api
  if (!await fileApi.parent.exists()) await createDir(fileApi.parent.path);
  //cek file api jika tidak ada maka buat baru
  if (!await fileApi.exists())
    await writeToFile(fileApi.path,
        safeRawDataClass((await dataClassApi)!.toBase64Decode, className));

  //buat request function pada api module
  String codeImportModel =
      "import '../models/${summary["Model"]!}/${summary["Model"]!}.dart';";
  String dataWrite = (await readFile(fileApi.path))!;
  final splitter = "ApiEndpoint _apiEndpoint = ApiEndpoint();";
  List<String> _datasplit = dataWrite.split(splitter);

  //jika tidak pakai model
  if (summary["Model"]!.isEmpty) {
    codeImportModel = "";
    modelNamePilihan = "Map<String,dynamic>";
  } else {
    //jika code import sudah ada
    if (_datasplit[0].contains(codeImportModel)) codeImportModel = "";
  }
  //cek endpoint
  String namaEndpoint = (summary["Module"]! +
          (summary["Request Name"]!).toPascalCase +
          "Endpoint")
      .toCamelCase;
  String configApi = (await readFile(defaultPathConfigApi))!;
  String codeEndpoint = "";

  if (summary["Endpoint"]!.startsWith(hostAlias)) {
    summary["Endpoint"] = summary["Endpoint"]!.replaceAll(hostAlias, "");
    codeEndpoint =
        "  String get $namaEndpoint => _hostApi + \"${summary["Endpoint"]}\";";
  } else if (configApi.contains(endPointUri.host)) {
    //jika host terdaftar di config api
    summary["Endpoint"] =
        summary["Endpoint"]!.replaceAll(endPointUri.origin, "");
    codeEndpoint =
        "  String get $namaEndpoint => _hostApi + \"${summary["Endpoint"]}\";";
  } else {
    //jika tidak terdaftar
    codeEndpoint = "  String get $namaEndpoint => \"${summary["Endpoint"]}\";";
  }

  //daftarkan endpoint di class endpoint
  String rawDataClassEndpoint = (await readFile(defaultPathEndpoint))!;
  String splitterEndpoint =
      "  //code-gen.dart - tolong jangan dihapus comment ini!";
  List<String> _datasplitEndpoint =
      rawDataClassEndpoint.split(splitterEndpoint);
  String? rawDataRequest = await dataRequestApi;

  await writeToFile(defaultPathEndpoint,
      "${_datasplitEndpoint[0]}$splitterEndpoint\n$codeEndpoint${_datasplitEndpoint[1]}");

  //write request to file
  Map<String, dynamic> jsonDataRequest =
      jsonDecode(rawDataRequest!.toBase64Decode);
  String codeRequest = safeRawDataRequestApi(
      (jsonDataRequest[methodNamePilihan.toLowerCase()]! as String)
          .toBase64Decode,
      modelNamePilihan,
      summary["Request Name"]!,
      namaEndpoint);

  dataWrite =
      "$codeImportModel\n${_datasplit[0]}$splitter\n$codeRequest\n${_datasplit[1]}";

  await writeToFile(fileApi.path, dataWrite);
  printSuccess("Tambah Api Request Sukses!");
}
