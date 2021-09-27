part of '../../code-gen.dart';

String defaultPathModules = translatePath("lib/modules");
String defaultPathModuleApi(String moduleName) =>
    translatePath("lib/modules/$moduleName/api");
String defaultPathModuleModels(String moduleName) =>
    translatePath("lib/modules/$moduleName/models");
String defaultPathModuleController(String moduleName) =>
    translatePath("lib/modules/$moduleName/controller");
String defaultPathModuleView(String moduleName) =>
    translatePath("lib/modules/$moduleName/view");
String defaultPathModuleViewLayout(String moduleName) =>
    translatePath("lib/modules/$moduleName/view/layout");
String defaultPathModuleViewWidget(String moduleName) =>
    translatePath("lib/modules/$moduleName/view/widget");
String defaultPathConfigApi = translatePath("lib/config/api.dart");
String defaultPathEndpoint =
    translatePath("lib/shared/utils/api/utils/api_endpoint.dart");
String defaultPathLanguageModel =
    translatePath("lib/shared/utils/language/language_model.dart");
String defaultPathRoutes = translatePath("lib/config/routes.dart");
String defaultPathApiConverter =
    translatePath("lib/shared/utils/api/utils/api_converter.dart");
//path data
String defaultPathToolsData(String filename) =>
    translatePath("tools/data/$filename");
//------------------------------------------------------------------------------
String translatePath(String path) {
  if (Platform.isWindows) {
    return path.replaceAll("/", "\\");
  } else {
    return path;
  }
}
