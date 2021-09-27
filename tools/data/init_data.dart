part of '../../code-gen.dart';

//======= DATA =================================================================
Future<String?> get dataRequestApi async =>
    await readFile(defaultPathToolsData("request_api.data"));
Future<String?> get dataClassApi async =>
    await readFile(defaultPathToolsData("class_api.data"));
Future<String?> get dataModule async =>
    await readFile(defaultPathToolsData("module.data"));
