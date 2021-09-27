import 'package:flutter/services.dart' show rootBundle;

Future<String> loadFileTextFromAssets(String path) async {
  return await rootBundle.loadString(path);
}
